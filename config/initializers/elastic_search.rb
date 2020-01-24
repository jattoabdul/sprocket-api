url = ENV['FOUNDELASTICSEARCH_URL'] || ENV['BONSAI_URL'] || ENV['ELASTICHSEARCH_URL']


if ENV['FOUNDELASTICSEARCH_URL']
  transport_options = {
    request: { timeout: 250 },
    headers: {
      Authorization: "Basic #{ENV['FOUNDELASTICSEARCH_TOKEN']}"
    }
  }
  options = {
    hosts: url,
    retry_on_failure: true,
    transport_options: transport_options
  }
  Searchkick.client = Elasticsearch::Client.new(options)
  # Searchkick.redis = ConnectionPool.new { Redis.new }
else
  transport_options = {
    request: { timeout: 250 },
  }
  options = {
    hosts: url,
    retry_on_failure: true,
    transport_options: transport_options
  }
  Searchkick.client = Elasticsearch::Client.new(options)
  # Searchkick.redis = ConnectionPool.new { Redis.new }
end
