#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require './lib/table.rb'
require './lib/scraper.rb'

input = gets.chomp
input = input.gsub(' ', '%20')
page = 1

scrape_site= Scraper.new(input, page)
scrape_site.scraper

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

    scrape_site= Scraper.new(input, page)
    scrape_site.scraper

    table_object = ScrapedTable.new(page, input)
    table_object.display_table
end

p '/*/ Thank you for using Ruby Today /*/'
p '/*/ Made with Ruby BC its AWESOME! /*/'
p "/*/ With us you can skip the Ads \u{1f600}/*/"