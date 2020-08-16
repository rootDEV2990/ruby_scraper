require 'terminal-table'

class ScrapedTable
  def initialize(page, input, total)
    @page = page
    @input = input
    @total = total
    @index = 0
  end

  def display_table
    Terminal::Table.new(
      rows: [
        [@total, @page, pages_index, user_query]
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

  private

  def pages_index
    @index = @total / 20
  end

  def user_query
    @input.gsub('%20', ' ')
  end
end
