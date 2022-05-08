class LmsParse

  def initialize
    @items = []
  end

  def total_pages
    @total_pages ||= begin
                       response = request(url)
                       per_page = response['items'].count.to_f
                       total_items = response['total']
                       (total_items / per_page).ceil
                     end
  end

  def parse
    (1..total_pages).each do |page|
      p response = request(url(page: page))
      @items.concat response['items']
    end
    @items
  end

  private

  def request(request_url)
    response = HTTParty.get(url)
    response.parsed_response
  end

  def url(page: 1, sort_by: 'LatestListed')
    "https://api-crypto.letmespeak.org/api/escrow?page=#{page}&sortBy=#{sort_by}"
  end

end