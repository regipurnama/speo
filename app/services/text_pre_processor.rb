class TextPreProcessor
	def initialize
		@tokenizer = PragmaticTokenizer::Tokenizer.new(language: :en, downcase: true, remove_stop_words: true, clean: true, downcase: true, classic_filter: true)
		@lex  = WordNet::Lexicon.new
	end

	def tokenize(text)
		@tokenizer.tokenize(text).map{ |word| word.stem.humanize }.correct_words
	end

	def synonymize_as_sentences(tokenized_text)
		text_collection = [tokenized_text.join(" ")]
		tokenized_text.each.with_index do |word, index_1|
			@lex[word].words.map(&:lemma).each.with_index do |synonym_word|
				text_collection << tokenized_text.dup.fill(synonym_word,index_1,1).join(" ")
			end
		end
		text_collection.uniq
	end

	def synonymize(tokenized_text)
		synonym_words = []
		tokenized_text.each.with_index do |word|
			@lex[word].words.map(&:lemma).each.with_index do |synonym_word|
				synonym_words << synonym_word
			end
		end
		(tokenized_text + synonym_words).uniq
	end
end