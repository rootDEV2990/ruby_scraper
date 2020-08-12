# require './bin/main.rb'
require './lib/scraper.rb'
require './lib/table.rb'

describe Scraper do
  let(:scraper) { Scraper.new('rick%20and%20morty', 2) }

  describe '.initialize' do
    it 'Check url builder in initialize method' do
      expect(scraper.url).to eq('https://katcr.to/usearch/rick%20and%20morty/2/')
    end
  end
  describe '.results_counter' do
    it 'Checks number of results available' do
      expect(scraper.results_counter).to eq(634)
    end
  end
  describe '.extract_torrent' do
    it 'Displays counter of list item' do
      torrent_list = scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[0].to_i).to eq(2)
    end
  end
  
end
