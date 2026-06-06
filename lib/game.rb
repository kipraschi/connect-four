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
        announce(:turn, player)
        column_index = player.choose_column - 1
        until @board.valid_move?(column_index)
          announce(:column_full)
          column_index = player.choose_column - 1
        end

        @board.update(column_index, player.marker)
        puts @board.display

        if game_over?
          @board.draw? ? announce(:draw, player) : announce(:winner, player)
          break
        end
      end
    end
  end

  private

  def game_over?
    @board.four_connected? || @board.draw?
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
    "Welcome to the game of Connect Four\n
    Take turns dropping your marker into one of the columns.\n 
    The first player to connect four in a row (horizontally, vertically or diagonally) wins.\n"
  end

  def turn_message(player)
    "#{player.name}, your turn.\n
    Choose the column (1-6) where you want your disk to go:"
  end

  def input_error
    'This column is not available. Choose another one:'
  end

  def draw_message
    "Game Over! It's a draw!"
  end

  def winner_message(player)
    "#{player.name} wins!"
  end
end
