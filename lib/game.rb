require_relative 'board'
require_relative 'player'
require_relative 'cli'

class Game
  def initialize(player1 = Player.new('◉', 'Player 1', CLI), player2 = Player.new('◎', 'Player 2', CLI), board = Board.new, display = CLI)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @board = board
    @display = display
  end

  def play
    @display.announce(:game_start)
    @display.render(@board.display)
    
    until game_over?
      @players.each do |player|
        play_turn(player)
        break if game_over?
      end
    end
  end

  private

  def play_turn(player)
    @display.announce(:turn, player)
    column_index = choose_valid_column(player)
    @board.update(column_index, player.marker)
    @display.render(@board.display)
    announce_game_result(player) if game_over?
  end

  def choose_valid_column(player)
    column_index = player.choose_column - 1
      until @board.valid_move?(column_index)
        @display.announce(:column_full)
        column_index = player.choose_column - 1
      end
    column_index
  end

  def game_over?
    @board.four_connected? || @board.draw?
  end

  def announce_game_result(player)
     @board.draw? ? @display.announce(:draw, player) : @display.announce(:winner, player)
  end
end
