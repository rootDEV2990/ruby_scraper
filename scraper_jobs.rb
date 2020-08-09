#!/usr/bin/env ruby
require 'Nokogiri'
require 'httparty'
require 'byebug'


def scraper
    url = "https://manoamano.com/resultados-de-busqueda/?utf8=%E2%9C%93&super_cat=4&filtro_foto=1&filtro_orden=1"
    raw_data = HTTParty.get(url)
    format_page = Nokogiri::HTML(raw_data)
    #byebug
    div = format_page.css('div.media-body')
    jobs = Array.new
    div.each do |posting|
        jobs << job = { Title: posting.css('div.title').text, Desc: posting.css('h4.desc-oferta').text }
    end
    p jobs[0...2]
end

scraper