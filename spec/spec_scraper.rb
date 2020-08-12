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
  
end
