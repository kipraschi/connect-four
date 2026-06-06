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
    end
  end

  private
  
  def valid_input?(input)
    input.match?(/\A[1-7]\z/)
  end
end