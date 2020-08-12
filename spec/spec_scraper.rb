# require './bin/main.rb'
require './lib/scraper.rb'

describe Scraper do
  describe '.initialize' do
    it 'Check url builder in initialize method' do
      session = Scraper.new('movie', 2)
      expect(session.url).to eq('https://katcr.to/usearch/movie/2/')
    end
  end
end
