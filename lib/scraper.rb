require 'Nokogiri'
require 'httparty'

class Scraper
    attr_accessor :query, :page

    def initialize(query, page)
        @page = page
        @query = query
    end



    def scraper
        if @page == 1
            @page = ''
        else
            @page = '/' + @page.to_s
        end
        url = "https://katcr.to/usearch/" + @query + @page + "/"
        raw_data = HTTParty.get(url)
        format_page = Nokogiri::HTML(raw_data)
        item_count = 0 
        div = format_page.css('table.data')
        table = div.css('tbody')
        table.css('tr').each do |table_item| 


            href = table_item.css('div.iaconbox a')
            url = href.map {|link| link['href']}
            
            
            title_extract = table_item.css('div.torrentname').text.to_s.split(/\n/)

            torrent_info = []
            title_extract.each {|text| torrent_info << text unless text.length == 0}
            p item_count += 1
            torrent_info.each_with_index {|title_item, index| p title_item unless index == 1 or index == 2 or index == 5}
            p "https://katcr.to#{url[0]}"
            p '***********************************************'
        end
    end
end