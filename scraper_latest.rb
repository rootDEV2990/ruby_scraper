#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require 'byebug'


def get_latest_news
    url = "https://visitpuertovallarta.com/covid19"
    raw_data = HTTParty.get(url)
    format_page = Nokogiri::HTML(raw_data)
    #byebug
    h3_tags = format_page.css('h3')
    p_tags = format_page.css('p')
    p title = h3_tags[0].text
    p latest_copy = p_tags[1].text
end

get_latest_news