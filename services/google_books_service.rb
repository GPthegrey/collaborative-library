class GoogleBooksService
  require 'net/http'
  require 'json'

  BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q='

  def initialize(api_key)
    @api_key = api_key
  end

  def search_books(query)
    url = URI.parse("#{BASE_URL}#{URI.encode(query)}&key=#{@api_key}")
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end
end
