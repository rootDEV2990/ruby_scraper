require 'terminal-table'

class ScrapedTable
  attr_accessor :page, :input, :total

  def initialize(page, input, total)
    @page = page
    @input = input
    @total = total
  end

  def display_table
    puts Terminal::Table.new(
      rows: [
        [@total, @page, (@total / 20), @input.gsub('%20', ' ')]
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
