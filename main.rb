require "pry-byebug"

class TicTacToe
  def initialize()
    puts "Enter player 1 name"
    @player1 = gets.chomp
    puts "Enter player 2 name"
    @player2 = gets.chomp
    @board = Array.new(3) {Array.new(3,:e)}
    @winner = -1
    @turn = Random.rand(1..2)
  end


  private 
  def change_turn 
    @turn +=1
    @turn = @turn % 2 if @turn >2
  end

  private
  def calculate_winner
    # in case of 3 adjacent cells
    @board.any? do |row|
      return @player1 if row.all? {|value| value == :x}
      return @player2 if row.all? {|value| value == :o}
    end

    # in case of 3 cells on top of each other
    0.upto(2) do |index|
      return @player1 if @board.all? {|row|row[index] == :x}
      return @player2 if @board.all? {|row| row[index] == :o}
    end

    # in case of 3 across
      if( @board[0][0] == @board[1][1] && @board[1][1] ==@board[2][2])
        return @player1 if @board[1][1] == :x
        return @player2 if @board[1][1] == :o
      end

      if (@board[0][2] == @board[1][1] && @board[1][1] ==@board[2][0])
        return @player1 if @board[1][1] == :x
        return @player2 if @board[1][1] == :o
      end

    return -1
  end

  private
  def make_move(row,column)
    if @board[row][column] != :e
      invalid_move
      return false
    end
    if @turn == 1
      @board[row][column] = :x 
    else
      @board[row][column] = :o
    end
  end

  private
  def display_board
    @board.each do |row|
      row.each_with_index do |cell, index|
        if cell == :o
           print "O"
        elsif cell == :x
           print "X"
        else
          print "_"
        end
        if index < 2
          print " | "
        end
      end
      puts
    end
  end

  public 
  def play_game()
    puts "New Game between #{@player1} and #{@player2}"
    until @winner != -1 do
      display_board
      puts @turn ==1 ? "#{@player1} make your move!": "#{@player2} make your move!"
      next_move = gets.chomp.split
      next_move.map! {|value| value.to_i}
      if(next_move.length !=2 || next_move[0] >2 || next_move[0] <0 || next_move[1] >2 || next_move[1] <0)
        invalid_input
        next
      end
      move = make_move(next_move[0], next_move[1])
      unless move
        next
      end

      @winner = calculate_winner
      unless  @winner == -1
        puts "#{@winner} WINS !!!!"
        display_board
      end
      change_turn
    end
  end

  private 
  def invalid_input
    puts "Invalid input: please input the row and column values between 0 and 2 separated by a space!"
  end

  def invalid_move
    puts "Invalid move, this cell is not empty"
  end
end

new_game = TicTacToe.new()
new_game.play_game