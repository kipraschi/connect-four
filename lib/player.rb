class Player
  def initialize(marker, name)
    @marker = marker
    @name = name
  end

  attr_reader :marker, :name

  def choose_column
    loop do
      input = gets.chomp
      return input.to_i if valid_input?(input)
      announce_invalid_input
    end
  end

  private
  
  def valid_input?(input)
    input.match?(/\A[1-7]\z/)
  end

  def announce_invalid_input
    puts "Invalid input, please choose a column number 1-7"
  end
end