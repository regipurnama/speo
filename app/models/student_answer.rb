# == Schema Information
#
# Table name: student_answers
#
#  id               :integer          not null, primary key
#  student_id       :integer          not null
#  question_id      :integer          not null
#  exam_question_id :integer
#  uni_gram_weight  :float(24)
#  bi_gram_weight   :float(24)
#  tri_gram_weight  :float(24)
#  score            :string(255)
#  quality          :float(24)
#  response         :text(65535)      not null
#  teacher_score    :float(24)        not null
#  system_score     :float(24)        default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StudentAnswer < ApplicationRecord
	attr_accessor :answer_term_frequency, :cluster

	belongs_to :student
  belongs_to :exam_question

  around_save :recalcuate_scores
  after_destroy :calculate_scores!

  def uni_gram_weight
    super || 0
  end

  def bi_gram_weight
    super || 0
  end

  def tri_gram_weight
    super || 0
  end

  def recalcuate_scores
    should_calculate_scores = response_changed?
    yield
    calculate_scores! if should_calculate_scores
  end

  def calculate_scores!
    text_pre_processor  = TextPreProcessor.new
    question            = exam_question.question
    student_answers     = exam_question.student_answers.includes(:student).to_a
    student_exam_scores = exam_question.exam.student_exam_scores.to_a
    total_answer        = student_answers.count

    tokenized_question_key  = text_pre_processor.tokenize(question.key)
    uni_gramed_key          = text_pre_processor.synonymize(tokenized_question_key)
    key_sentence_collection = text_pre_processor.synonymize_as_sentences(tokenized_question_key)
    key_n_gram              = NGram.new(key_sentence_collection, n: [2,3])
    answers_n_gram          = NGram.new(exam_question.student_answers.pluck(:response), n: [2,3])
    bi_gramed_key           = key_n_gram.ngrams_of_all_data[2].keys
    tri_gramed_key          = key_n_gram.ngrams_of_all_data[3].keys

    tf_processor = TermFrequencyProcessor.new(
      uni_gramed_key,
      key_n_gram.ngrams_of_all_data[2],
      key_n_gram.ngrams_of_all_data[3],
    )

    student_answers.each.with_index do |student_answer, index|
      answer_word_collection  = text_pre_processor.tokenize(student_answer.response)
      student_answer.answer_term_frequency = {}
      student_answer.answer_term_frequency[:uni_gram] = tf_processor.calculate_unigram(answer_word_collection)
      student_answer.answer_term_frequency[:bi_gram]  = tf_processor.calculate_bigram(answers_n_gram.ngrams_of_inputs[index][2])
      student_answer.answer_term_frequency[:tri_gram] = tf_processor.calculate_trigram(answers_n_gram.ngrams_of_inputs[index][3])
    end

    [:uni_gram, :bi_gram, :tri_gram].each do |n_gram_type|
      eval("#{n_gram_type}ed_key").each do |key_word|
        document_frequency = 0
        student_answers.each do |student_answer|
          answer_term_frequency = student_answer.answer_term_frequency[n_gram_type][key_word]
          document_frequency += 1 if !answer_term_frequency.zero?
        end

        idf = Math.log10((total_answer/document_frequency.to_f)).round(3) unless document_frequency.zero?

        student_answers.each.with_index do |student_answer, index|
          if !document_frequency.zero?
            answer_term_frequency = student_answer.answer_term_frequency[n_gram_type][key_word]
            wdt = idf * answer_term_frequency
            wdt = student_answer.public_send("#{n_gram_type}_weight") + wdt
            student_answer.public_send("#{n_gram_type}_weight=", wdt)
          end
        end
      end
    end

    samples      = student_answers.sample(4).map{|sa| [sa.uni_gram_weight, sa.bi_gram_weight, sa.tri_gram_weight]}
    clusters     = {}
    new_clusters = nil
    do_iteration = true

    while do_iteration
      student_answers.each do |student_answer|
        transformed_weight = samples.map{|sample|
          Math.sqrt(
            ((student_answer.uni_gram_weight.to_f - sample[0]) ** 2) +
            ((student_answer.bi_gram_weight.to_f - sample[1]) ** 2) +
            ((student_answer.tri_gram_weight.to_f - sample[2]) ** 2)
          )
        }

        student_answer.cluster = transformed_weight.index(transformed_weight.min)
      end

      new_clusters = student_answers.map(&:cluster)
      do_iteration = (clusters != new_clusters) == true

      if do_iteration
        samples = []
        4.times do |i|
          current_cluster_student_answers = student_answers.select{|sa| sa.cluster == i}
          uni = current_cluster_student_answers.map(&:uni_gram_weight)
          bi  = current_cluster_student_answers.map(&:bi_gram_weight)
          tri = current_cluster_student_answers.map(&:tri_gram_weight)
          uni_sample = uni.size.zero? ? 0 : (uni.sum / uni.size)
          bi_sample  = bi.size.zero? ? 0 : (bi.sum / bi.size)
          tri_sample = tri.size.zero? ? 0 : (tri.sum / tri.size)

          samples << [
            uni_sample,
            bi_sample,
            tri_sample
          ]
        end

        clusters     = new_clusters
        new_clusters = {}
      end
    end

     #grouped_student_answers = student_answers.group_by{|sa| sa.cluster}
    sorted_cluster = {}
    highest_score  = 'A'
    total_value = 0
    4.times do
      filtered_student_answers = student_answers.reject{|sa| sorted_cluster.include?(sa.cluster) }
      highest_student_answer   = filtered_student_answers.max_by{|sa|
        (sa.uni_gram_weight.to_f +
        sa.bi_gram_weight.to_f +
        sa.tri_gram_weight.to_f)
      }
      next if highest_student_answer.nil?
      sorted_cluster[highest_student_answer.cluster] = highest_score
      highest_score = highest_score.next
    end

    sorted_cluster.each do |cluster, score|
      ActiveRecord::Base.transaction do
        student_answers.select{|sa| sa.cluster == cluster}.each do |sa|
          sa.score = score
            if score == "A"
              sa.quality = 4.0
            elsif score == "B"
              sa.quality = 3.0
            elsif score == "C"
              sa.quality = 2.0
            elsif score == "D"
              sa.quality = 1.0
            else
              sa.quality = 0
            end
          sa.save
        end
      end
    end

    exam_question.exam.calculate_quality_and_score!
  end
end
