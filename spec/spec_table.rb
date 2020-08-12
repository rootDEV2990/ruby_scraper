require './lib/table.rb'

describe ScrapedTable do
  let(:table) { ScrapedTable.new(1, 'rick%20and%20morty', 634) }

  describe '.pages_index' do
    it 'devides the total of results for page panning' do
      expect(table.pages_index).to eq(31)
    end
  end

  describe '.user_query' do
    it 'Extracts user query from url and makes human readable.' do
      expect(table.user_query).to eq('rick and morty')
    end
  end
end
