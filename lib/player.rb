class Player
  def initialize(marker, name, display)
    @marker = marker
    @name = name
    @display = display
  end

  attr_reader :marker, :name

  def choose_column
    loop do
      input = @display.get_input
      return input.to_i if valid_input?(input)
      @display.announce(:invalid_input)
    end
  end

  private
  
  def valid_input?(input)
    input.match?(/\A[1-7]\z/)
  end
end