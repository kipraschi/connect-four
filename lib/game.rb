require_relative 'board'
require_relative 'player'

class Game
  def initialize(player1 = Player.new('◉', 'Player 1'), player2 = Player.new('◎', 'Player 1'), board = Board.new)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @board = board
  end

  def play
    announce(:game_start)
    puts @board.display
    
    until game_over?
      @players.each do |player|
        play_turn(player)
        break if game_over?
      end
    end
  end

  private

  def play_turn(player)
    announce(:turn, player)
    column_index = choose_valid_column(player)
    @board.update(column_index, player.marker)
    puts @board.display
    announce_game_result(player) if game_over?
  end

  def choose_valid_column(player)
    column_index = player.choose_column - 1
      until @board.valid_move?(column_index)
        announce(:column_full)
        column_index = player.choose_column - 1
      end
    column_index
  end

  def game_over?
    @board.four_connected? || @board.draw?
  end

  def announce_game_result(player)
     @board.draw? ? announce(:draw, player) : announce(:winner, player)
  end

  def announce(message, player = nil)
    case message
      when :game_start then puts start_message
      when :turn then print turn_message(player)
      when :draw then puts draw_message
      when :winner then puts winner_message(player)
      when :column_full then print input_error
    end
  end

  def start_message
    <<~TEXT
    
    Welcome to the game of Connect Four

    Take turns dropping your marker into one of the columns.
    The first player to connect four in a row (horizontally, vertically or diagonally) wins.

    TEXT
  end

  def turn_message(player)
    <<~TEXT

    #{player.name}, your turn.
    Choose the column (1-6) where you want your disk to go:
    TEXT
  end

  def input_error
    "\nThis column is not available. Choose another one: "
  end

  def draw_message
    "Game Over! It's a draw!"
  end

  def winner_message(player)
    "#{player.name} wins!"
  end
end
