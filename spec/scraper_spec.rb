require './lib/scraper.rb'

describe Scraper do
  before(:all) do
    @scraper = Scraper.new('rick%20and%20morty', 2)
    @scraper.get_data
  end

  describe '.initialize' do
    it 'Check url builder in initialize method' do
      expect(@scraper.instance_variable_get(:@url)).to eq('https://katcr.to/usearch/rick%20and%20morty/2/')
    end
    it 'Check that url is built dynamicly and that urls are not equal' do
      new_session = Scraper.new('modern%20family', 2)
      expect(@scraper.instance_variable_get(:@url)).to_not eq(new_session.instance_variable_get(:@url))
    end
  end
  describe '.results_counter' do
    it 'Checks number of results available' do
      expect(@scraper.results_counter).to eq(634)
    end
    it 'Check that counter is built dynamicly' do
      new_session = Scraper.new('modern%20family', 2)
      new_session.get_data
      expect(@scraper.results_counter).to_not eq(new_session.results_counter)
    end
  end
  describe '.extract_torrent' do
    it 'Displays counter of list item' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[0].to_i).to eq(2)
    end
    it 'Checks if counter is increasing' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[2].each { |item| first_torrent << item }
      expect(first_torrent[0].to_i).to_not eq(2)
    end
  end
  describe '.extract_torrent' do
    it 'Displays name of torrent of list item' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[1]).to eq("Rick and Morty S04E03 720p WEBRip x264-TBS eztv \n")
    end
    it 'Check list item names are not repeating' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[2].each { |item| first_torrent << item }
      expect(first_torrent[1]).to_not eq("Rick and Morty S04E03 720p WEBRip x264-TBS eztv \n")
    end
  end
  describe '.extract_torrent' do
    it 'Displays name genre of torrent in list' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[5]).to eq("TV  >\n")
    end
    it 'Checks that torrents are not getting duplicated' do
      torrent_list = @scraper.extract_torrent
      first_torrent = []
      torrent_list[1].each { |item| first_torrent << item }
      expect(first_torrent[6]).to_not eq("TV  >\n")
    end
  end
end
