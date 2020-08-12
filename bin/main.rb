#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require './lib/table.rb'
require './lib/scraper.rb'

class FetchTorrents < Scraper
  attr_accessor :input, :page

  def initialize
    @input = gets.chomp
    @input = @input.gsub(' ', '%20')
    @page = 1
    @crawling = true
  end

  def crawling_site
    while @crawling == true
      p 'To jump to a new page enter it bellow, or enter a new query. Type exit to exit the script.'
      new_query = gets.downcase.chomp.to_s
      if new_query == 'exit'
        @crawling = false
      elsif new_query.to_i.zero?
        @input = new_query.to_s.gsub(' ', '%20')
        @page = 1
      elsif new_query.to_i > (@total / 20)
        p 'Page does not exist, wait 3 seconds for reboot.'
        sleep(3)
      else
        @page = new_query.to_i
      end
      display_results
    end
  end

  def display_results
    scrape_site = Scraper.new(@input, @page)
    puts scrape_site.extract_torrent
    @total = scrape_site.total_results
    table_object = ScrapedTable.new(@page, @input, @total)
    table_object.display_table
    crawling_site
  end
end

p '/-/-/-/-/Search Torrents with Ruby and skip the pop-ups./-/-/-/-/'
p '/-/-/-/-/Whats the name of the torrent you need pirate?/-/-/-/-/'
app = FetchTorrents.new
app.display_results
p '/*/ Thank you for using Ruby Today /*/'
p '/*/ Made with Ruby BC its AWESOME! /*/'
p "/*/ Skip the Ads with your terminal/*/"
p "/*/ Made by rootDEV2990  #codeIT \u{1f600}/*/"
