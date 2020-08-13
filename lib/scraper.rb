require 'nokogiri'
require 'httparty'

class Scraper
  attr_reader :total_results

  def initialize(query, page)
    @page = page
    @query = query
    @page = if @page == 1
              ''
            else
              '/' + @page.to_s
            end
    @url = 'https://katcr.to/usearch/' + @query + @page + '/'
    @item_count = 0
    @total_results = 0
    
  end

  def get_data
    @raw_data = HTTParty.get(@url)
    @format_page = Nokogiri::HTML(@raw_data)
    div = @format_page.css('table.data')
    @table = div.css('tbody')
  end

  def results_counter
    h2 = @format_page.css('a.plain').text.split("\n")
    search_results = if !h2[1].nil?
                       h2[1].split(' ')
                     else
                       h2.push('0')
                     end
    @total_results = search_results[-1].to_i
    @total_results
  end

  def extract_torrent
    results_counter
    torrent_list = []
    @table.css('tr').each do |table_item|
      list_item = []
      href = table_item.css('div.iaconbox a')
      @url = href.map { |link| link['href'] }
      title_extract = table_item.css('div.torrentname').text.to_s.split(/\n/)
      torrent_decrypt = []
      title_extract.each { |text| torrent_decrypt << text unless text.empty? }
      list_item << (@item_count += 1).to_s
      torrent_decrypt.each { |title_item| list_item << title_item.to_s + "\n" }
      list_item << "https://katcr.to#{@url[0]}\n"
      list_item << "***********************************************\n"
      torrent_list << list_item
    end
    torrent_list
  end
end
