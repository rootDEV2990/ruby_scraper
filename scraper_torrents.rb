#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require 'terminal-table'
require 'byebug'


def scraper
    url = "https://katcr.to/usearch/rick%20and%20morty/"
    raw_data = HTTParty.get(url)
    format_page = Nokogiri::HTML(raw_data)
    #byebug
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

    

    #∫torrents = Array.new
    #∫div.each do |li|
        #∫torrents << torrent = { Title: li.css('span.item-title#reference a').text, Desc: li.css('span.item-icons#reference a').text }
    #∫end
    #∫p torrents[0...2]
end

scraper

puts Terminal::Table.new(
    rows: [
        [15385, 1, 300, search = 'Rick and Morty'],
    ],
    headings: [
        'Total Results',
        'Page Loaded',
        'Total Pages',
        'Searched'
    ],
    style: {
        border_i: '*'
    }
)

p 'To jump to a new page enter it bellow, or enter a new query. Type exit to exit the script.'
p search = gets.chomp
