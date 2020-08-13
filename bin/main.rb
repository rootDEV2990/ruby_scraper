#!/usr/bin/env ruby
require 'nokogiri'
require 'httparty'
require_relative '../lib/table.rb'
require_relative '../lib/scraper.rb'

def app
  p '/-/-/-/-/Search Torrents with Ruby and skip the pop-ups./-/-/-/-/'
  p '/-/-/-/-/Whats the name of the torrent you need pirate?/-/-/-/-/'
  input = gets.chomp
  input = input.gsub(' ', '%20')
  page = 1
  display_results(page, input)
end

def crawling_site(total, input, page)
  loop do
    p 'To jump to a new page enter it bellow, or enter a new query. Press Ctrl+C on your keyboard to exit.'
    new_query = gets.downcase.chomp
    if new_query.to_i.zero?
      input = new_query.to_s.gsub(' ', '%20')
      page = 1
    elsif new_query.to_i > (total / 20)
      p 'Page does not exist, wait 3 seconds for reboot.'
      sleep(3)
      page = page
    else
      page = new_query.to_i
    end
    display_results(page, input)
  end
end

def display_results(page, input)
  scrape_site = Scraper.new(input, page)
  scrape_site.data
  puts scrape_site.extract_torrent
  total = scrape_site.total_results
  table_object = ScrapedTable.new(page, input, total)
  puts table_object.display_table
  crawling_site(total, input, page)
end

app

p '/*/ Thank you for using Ruby Today /*/'
p '/*/ Made with Ruby BC its AWESOME! /*/'
p '/*/ Skip the Ads with your terminal/*/'
p "/*/ Made by rootDEV2990  #codeIT \u{1f600}/*/"
