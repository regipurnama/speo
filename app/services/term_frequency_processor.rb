class TermFrequencyProcessor
	def initialize(unigram_key, bigram_key, trigram_key)
		@unigram_key = unigram_key
		@bigram_key  = bigram_key 
		@trigram_key = trigram_key
	end

	def calculate_unigram(words)
		@unigram_key.inject({}) do |result, word|
			result[word] = words.select{|w| w == word}.size 
			result
		end
	end

	def calculate_bigram(bigramed_words)
		calculate_n_gramed_words(@bigram_key, bigramed_words)
	end

	def calculate_trigram(trigramed_words)
		calculate_n_gramed_words(@trigram_key, trigramed_words)
	end

	private
	def calculate_n_gramed_words(n_gram_key, n_gramed_words)
		n_gram_key.inject({}) do |result, (text, count)|
			result[text] = n_gramed_words[text] || 0
			result
		end
	end
end