class Board
  attr_reader :grid
  def initialize (height = 6, width = 7)
    @height = height
    @width = width
    @empty_cell = '◯'
    @grid = Array.new(@width) { Array.new(@height) {@empty_cell} }
  end

  def display
    puts @grid.transpose.map { |row| row.join(' ') }
  end

  def update(column_index, symbol)
    column = @grid[column_index]
    index_of_last_empty_cell = column.rindex(@empty_cell)
    @grid[column_index][index_of_last_empty_cell] = symbol
  end

  def valid_move?(column_index)
    return false unless column_exists?(column_index)
    space_left_in_column?(column_index)
  end

  private

  def column_exists?(column_index)
    column_index.between?(0, @width - 1)
  end

  def space_left_in_column?(column_index)
    @grid[column_index].any?(@empty_cell)
  end

end