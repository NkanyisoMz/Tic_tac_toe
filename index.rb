class Game

    def initialize
        @board = Board.new
        @player1 = Players.new("X","Player 1")
        @player2 = Players.new("O","Player 2")
        @current_player = @player1
    end

    def start
        puts "Welcome to Tic-Tac-Toe!"
        until winner?
            turn
            switch_players
        end
        puts "Game over! #{@current_player.name} wins"
    end

    def turn
        puts "#{@current_player.name}'s turn:"
        @board.display
        move = @current_player.get_move
        @board.update(move,@current_player.symbol)
    end

    def switch_players
        @current_player = @current_player == @player1? @player2: @player1
    end

    def winner?
        @board.chech_winner
    end

end

class Board
    def initialize
        @state= Array.new(3){Array.new(3,"")}
    end

    def display 
        puts "#{@state[0][0]}| #{@state[0][1]}| #{@state[0][2]}"
        puts "_______"
        puts "#{@state[1][0]}| #{@state[1][1]}| #{@state[1][2]}"
        puts "_______"
        puts "#{@state[2][0]}| #{@state[2][1]}| #{@state[2][2]}"
    end

    def update(move,symbol)
        row,col = move
        @state[row][col] = symbol
    end

    def chech_winner
        #Check rows, cols, and diagonals for a winner
        (0..2).each do |row|
            return @state[row][0] if @state[row][0]==
            @state[row][1] && @state[row][1]==
            @state[row][2] && @state[row][0]!=""
        end

        (0..2).each do |col|
            return @state[0][col] if @state[0][col]==
            @state[1][col] && @state[1][col]==
            @state[2][col] && @state[0][col]!=""
        end

        return @state[0][0] if @state[0][0]==
        @state[1][1] && @state[1][1] == @state[2][2]
         && @state [0][0] != ""
        return @state[0][2] if @state[0][2] == @state[1][1]
        && @state[1][1] == !state[2][0] && @state[0][2]!=""
        
        
        #Return the winner's symbol or nil
        nil
    end
end

class Player
    def initialize(symbol,name)
        @symbol = symbol
        @name = name
    end

    def get_move
        puts "Enter row and column (0-2):"
        gets.chomp.split.map(&:t0_i)
    end
end

game = Game.new
game.start
