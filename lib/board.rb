class Board
  attr_reader :grid
  def initialize
    @height = 6
    @width = 7
    @empty_cell = '〇'
    @grid = Array.new(@width) { Array.new(@height) {@empty_cell} }
  end

  def display
    puts @grid.transpose.map { |row| row.join }
  end

  def update(column_index, symbol)
    column = @grid[column_index]
    index_of_last_empty_cell = column.rindex(@empty_cell)
    @grid[column_index][index_of_last_empty_cell] = symbol
  end
end