class TextPreProcessor
	def initialize
		@tokenizer = PragmaticTokenizer::Tokenizer.new(language: :en, downcase: true, remove_stop_words: true, stop_words: NEW_STOP_WORDS)
	end

	def tokenize(text)
		# asd if text.include? 'one'
		@tokenizer.tokenize(text).map{ |word| word.stem.humanize.gsub(/\W+/, '') }.reject(&:blank?).correct_words
	end

	def synonymize_as_sentences(tokenized_text)
		text_collection = [tokenized_text.join(" ")]
		tokenized_text.each.with_index do |word, index_1|
			synsets = WordNet::Synset.find_all(word)
			synsets.map(&:words).flatten.reject{|w| w.include?('_')}.each do |synonym_word|
				text_collection << tokenized_text.dup.fill(synonym_word,index_1,1).join(" ")
			end
		end
		text_collection.uniq
	end

	def synonymize(tokenized_text)
		synonym_words = []
		tokenized_text.each.with_index do |word|
			synsets = WordNet::Synset.find_all(word)
			synonym_words.concat(synsets.map(&:words).flatten.reject{|w| w.include?('_')})
		end
		(synonym_words + tokenized_text).uniq
	end
end