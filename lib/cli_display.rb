module CLIDisplay
  def self.announce(message, player = nil)
    case message
      when :game_start then puts start_message
      when :turn then print turn_message(player)
      when :draw then puts draw_message
      when :winner then puts winner_message(player)
      when :column_full then print column_error
      when :invalid_input then print input_error
    end
  end
  
  def self.render(string)
    puts string
  end

  private

  def self.start_message
    <<~TEXT
    
    Welcome to the game of Connect Four
    
    Take turns dropping your marker into one of the columns.
    The first player to connect four in a row (horizontally, vertically or diagonally) wins.
    
    TEXT
  end

  def self.turn_message(player)
    <<~TEXT
    
    #{player.name}, your turn.
    Choose the column (1-7) where you want your disk to go: 
    TEXT
  end

  def self.column_error
    "\nThis column is full. Choose another one: "
  end

  def self.draw_message
    "Game Over! It's a draw!"
  end

  def self.winner_message(player)
    "#{player.name} wins!"
  end

  def self.input_error
    "Invalid input, please choose a column number 1-7: "
  end

end