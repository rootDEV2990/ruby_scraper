require 'terminal-table'



class ScrapedTable
    attr_accessor :page, :input

    def initialize(page, input)
        @page = page
        @input = input
    end
    
    def display_table
        puts Terminal::Table.new(
            rows: [
                [15385, @page, 300, @input.gsub('%20', ' ')],
            ],
            headings: [
                'Total Results',
                'Page Loaded',
                'Total Pages',
                'Searched'
            ],
            style: {
                border_i: '*'
            }
        )
    end
    
end
