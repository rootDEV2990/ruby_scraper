#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require './lib/table.rb'

input = gets.chomp
input = input.gsub(' ', '%20')
page = 1

def scraper(query, page)
    if page == 1
        page = ''
    else
        page = '/' + page.to_s
    end
    url = "https://katcr.to/usearch/" + query + page + "/"
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

scraper(input, page)

table_object = ScrapedTable.new(page, input)
table_object.display_table

crawling = true

while crawling == true


    p 'To jump to a new page enter it bellow, or enter a new query. Type exit to exit the script.'
    new_query = gets.downcase.chomp
    
    if new_query == 'exit'
        crawling = false
    elsif new_query.to_i == 0
        input = new_query.to_s.gsub(' ', '%20')
        page = 1
    else
        page = new_query.to_i
    end

    scraper(input, page)

    table_object = ScrapedTable.new(page, input)
    table_object.display_table
end

p '/*/ Thank you for using Ruby Today /*/'
p '/*/ Made with Ruby BC its AWESOME! /*/'
p "/*/ With us you can skip the Ads \u{1f600}/*/"