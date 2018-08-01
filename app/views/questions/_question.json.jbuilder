json.extract! question, :id, :qtype, :tittle, :qline, :options, :created_at, :updated_at
json.url question_url(question, format: :json)
