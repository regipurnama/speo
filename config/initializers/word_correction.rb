CACHED_CORRECT_WORDS = { compani: 'company' }

class WordCorrection
  GINGER_API_ENDPOINT = 'http://services.gingersoftware.com/Ginger/correct/json/GingerTheText'
  GINGER_API_VERSION  = '2.0'
  GINGER_API_KEY      = '6ae0c3a0-afdc-4532-a810-82ded0054236'
  DEFAULT_LANG        = 'US'
  SEPARATOR           = '. '

	def self.correct(words)
		is_string = words.kind_of? String
		words = [words] if is_string
		result = []
		words_to_correct = []

		words.each.with_index do |word, index|
			word        = word.downcase.remove("-")
			cached_word = CACHED_CORRECT_WORDS[word.to_sym]

			if cached_word.nil?
				words_to_correct << word
			else
				result << cached_word
			end
		end

		if words_to_correct.present?
			@text = words_to_correct.join(SEPARATOR).chomp
			perform_request

			words_to_correct.each.with_index do |word, index|
				correct_word = @response['LightGingerTheTextResult'][index]['Suggestions'][0]['Text'].downcase
				CACHED_CORRECT_WORDS[word.to_sym] = correct_word
				result << correct_word
			end
		end

		is_string ? result[0] : result
	end

	private

	def self.perform_request
		http_request = HTTParty.get(build_url(text: @text))
    @response = JSON.parse(http_request.body)
	end

	def self.build_url(params)
		base_params = {
		  clientVersion: GINGER_API_VERSION,
		  apiKey: GINGER_API_KEY,
		  lang: DEFAULT_LANG,
		}

		GINGER_API_ENDPOINT + '?' + base_params.merge(params).to_query
	end
end