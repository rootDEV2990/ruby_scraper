#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require 'terminal-table'
require './table.rb'

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

puts Terminal::Table.new(
    rows: [
        [15385, page, 300, input.gsub('%20', ' ')],
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

searching = true

while searching == true


    p 'To jump to a new page enter it bellow, or enter a new query. Type exit to exit the script.'
    new_query = gets.downcase.chomp
    
    if new_query == 'exit'
        searching = false
    elsif new_query.to_i == 0
        input = new_query.to_s
        page = 1
    else
        page = new_query.to_i
    end

    scraper(input, page)

    puts Terminal::Table.new(
        rows: [
            [15385, page, 300, input.gsub('%20', ' ')],
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
end

p'*/*/*/*/*/*/*/*/**/*/*/*/*/*'

