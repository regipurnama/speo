json.extract! high_score, :id, :game, :score, :level, :created_at, :updated_at
json.url high_score_url(high_score, format: :json)
