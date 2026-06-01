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

  def four_connected?
    four_vertically? || four_horizontally? || four_diagonally?
  end

  private

  def four_vertically?
    @grid.each do |column|
      column.each_with_index do |cell, row_index|
        next if cell == @empty_cell
        next if row_index > 2
        return true if (1..3).all? {|offset| cell == column[row_index + offset]}
      end
    end
    false
  end

  def four_horizontally?
    @grid.each_with_index do |column, column_index|
      break if column_index > 3
      column.each_with_index do |cell, row_index|
        next if cell == @empty_cell
        return true if (1..3).all? { |offset| cell == @grid[column_index + offset][row_index] }
      end
    end
    false
  end

  def four_diagonally?
    @grid.each_with_index do |column, column_index|
      break if column_index > 3
      column.each_with_index do |cell, row_index|
        next if cell == @empty_cell
        if row_index <=2
          return true if (1..3).all? { |offset| cell == @grid[column_index + offset][row_index + offset] }
        end
        if row_index >=3
          return true if (1..3).all? { |offset| cell == @grid[column_index + offset][row_index - offset] }
        end
      end
    end
    false
  end

  def column_exists?(column_index)
    column_index.between?(0, @width - 1)
  end

  def space_left_in_column?(column_index)
    @grid[column_index].any?(@empty_cell)
  end

end