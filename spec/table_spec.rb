require './lib/table.rb'

describe ScrapedTable do
  let(:table) { ScrapedTable.new(1, 'rick%20and%20morty', 634) }

  describe '.pages_index' do
    it 'devides the total of results for page panning' do
      private_method = table.send(:pages_index)
      expect(private_method).to eq(31)
    end
    it 'Checks that index and that total results are diff' do
      private_method = table.send(:pages_index)
      expect(private_method).to_not eq(table.instance_variable_get(:@total))
    end
  end

  describe '.user_query' do
    it 'Extracts user query from url and makes human readable.' do
      private_method = table.send(:user_query)
      expect(private_method).to eq('rick and morty')
    end
    it 'Checks that displayed query is not same as url query' do
      private_method = table.send(:user_query)
      expect(private_method).to_not eq(table.instance_variable_get(:@input))
    end
  end
end
