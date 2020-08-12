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
  describe '.extract_torrent' do
    it 'Displays name of torrent of list item' do
      torrent_list = scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[1]).to eq("Rick and Morty S04E03 720p WEBRip x264-TBS eztv \n")
    end
  end
  describe '.extract_torrent' do
    it 'Displays name genre of torrent in list' do
      torrent_list = scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[5]).to eq("TV  >\n")
    end
  end
end


