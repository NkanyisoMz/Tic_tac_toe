class Game
    def initialize
        @board = Board.new
        @player1 = Player.new("X", "Player 1")
        @player2 = Player.new("O", "Player 2")
        @current_player = @player1
    end

    def start
        puts "Welcome to Tic-Tac-Toe!"
        loop do
            play_game
            puts "Do you want to play again? (yes/no)"
            answer = gets.chomp.downcase
            break unless answer == "yes"
            reset_game
        end
        puts "Thank you for playing Tic-Tac-Toe!"
    end

    def play_game
        until winner? || draw?
            turn
            switch_players
        end
        if winner?
            puts "Game over! #{@current_player.name} wins"
        else
            puts "It's a draw!"
        end
    end

    def turn
        puts "#{@current_player.name}'s turn:"
        @board.display
        move = @current_player.get_move(@board)
        @board.update(move, @current_player.symbol)
    end

    def switch_players
        @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def winner?
        @board.check_winner
    end

    def draw?
        @board.full? && !winner?
    end

    def reset_game
        @board = Board.new
        @current_player = @player1
    end
end

class Board
    def initialize
        @state = Array.new(3) { Array.new(3, "") }
    end

    def display
        display_board = @state.flatten.each_with_index.map { |cell, i| cell.empty? ? (i + 1).to_s : cell }
        puts " #{display_board[0]} | #{display_board[1]} | #{display_board[2]}"
        puts "---------"
        puts " #{display_board[3]} | #{display_board[4]} | #{display_board[5]}"
        puts "---------"
        puts " #{display_board[6]} | #{display_board[7]} | #{display_board[8]}"
    end

    def update(move, symbol)
        row, col = move
        @state[row][col] = symbol
    end

    def check_winner
        # Check rows, columns, and diagonals for a winner
        (0..2).each do |row|
            return @state[row][0] if @state[row][0] == @state[row][1] && @state[row][1] == @state[row][2] && @state[row][0] != ""
        end

        (0..2).each do |col|
            return @state[0][col] if @state[0][col] == @state[1][col] && @state[1][col] == @state[2][col] && @state[0][col] != ""
        end

        return @state[0][0] if @state[0][0] == @state[1][1] && @state[1][1] == @state[2][2] && @state[0][0] != ""
        return @state[0][2] if @state[0][2] == @state[1][1] && @state[1][1] == @state[2][0] && @state[0][2] != ""

        # Return the winner's symbol or nil
        nil
    end

    def full?
        @state.flatten.none?(&:empty?)
    end

    def valid_move?(move)
        row, col = move
        (0..2).cover?(row) && (0..2).cover?(col) && @state[row][col].empty?
    end
end

class Player
    attr_reader :symbol, :name

    def initialize(symbol, name)
        @symbol = symbol
        @name = name
    end

    def get_move(board)
        loop do
            puts "Enter a cell number (1-9) #{@name}:"
            input = gets.chomp.to_i
            if (1..9).cover?(input)
                move = convert_to_coordinates(input)
                return move if board.valid_move?(move)
                puts "Invalid move. The cell is already taken."
            else
                puts "Invalid input. Please enter a number between 1 and 9."
            end
        end
    end

    private

    def convert_to_coordinates(input)
        mapping = {
            1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
            4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
            7 => [2, 0], 8 => [2, 1], 9 => [2, 2]
        }
        mapping[input]
    end
end

game = Game.new
game.start
