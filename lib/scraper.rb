require 'Nokogiri'
require 'httparty'

class Scraper
  attr_accessor :query, :page, :total_results, :url

  def initialize(query, page)
    @page = page
    @query = query
    @page = if @page == 1
              ''
            else
              '/' + @page.to_s
            end
    @url = 'https://katcr.to/usearch/' + @query + @page + '/'
    @raw_data = HTTParty.get(@url)
    @format_page = Nokogiri::HTML(@raw_data)
    @item_count = 0
    @total_results = 0
  end

  def scraper
    div = @format_page.css('table.data')
    @table = div.css('tbody')
    results_counter
    extract_torrent
  end

  def results_counter
    h2 = @format_page.css('a.plain').text.split("\n")
    search_results = if !h2[1].nil?
                       h2[1].split(' ')
                     else
                       h2.push('0')
                     end
    @total_results = search_results[-1].to_i
  end

  def extract_torrent
    @table.css('tr').each do |table_item|
      href = table_item.css('div.iaconbox a')
      @url = href.map { |link| link['href'] }
      title_extract = table_item.css('div.torrentname').text.to_s.split(/\n/)
      torrent_info = []
      title_extract.each { |text| torrent_info << text unless text.empty? }
      p @item_count += 1
      torrent_info.each { |title_item| p title_item }
      p "https://katcr.to#{@url[0]}"
      p '***********************************************'
    end
  end
end
