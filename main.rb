class Player
  attr_reader :name , :marker
  attr_accessor :points
  
  def initialize(name,marker)
    @name = name
    @marker= marker
    @points=Array.new(0)
  end
  def show_player_info()
    puts "Player #{@name} marker is #{@marker}"
  end
  def add_mark(position)
    @points.insert(position,@marker)
  end    
end 
class Game
  WINNING = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  def initialize()
    @board=Array[0,1,2,3,4,5,6,7,8]
    puts "What is first players's name?"
    @player1=Player.new(gets.chomp,"X")
    @player1.show_player_info()
    puts "What is scound players's name?"
    @player2=Player.new(gets.chomp,"O")
    @player2.show_player_info()
    print_board()
  end
  def print_board()
    puts @board.each_slice(3).map { |row| row.join(" | ") }.join("\n" + "--+---+--" + "\n")
  end
  def play()
    turnCount=2
    0.upto(@board.length) do
      if turnCount % 2 == 0
        play_turn(@player1)
          if game_won?(@player1) 
            print_board()
            puts "#{@player1.name} won! GG"
            break
          end  
        else
        play_turn(@player2)
          if game_won?(@player2) 
            print_board()
            puts "#{@player2.name} won! GG"
            break
          end  
      end
      print_board()
      turnCount+=1
    end
  end  

  def game_won?(player)
    WINNING.any? do |line|
      line.all? { |pos| player.points[pos] == player.marker }
    end
  end

  def play_turn(player)
    puts "#{player.name} select your position:"
        selection = gets.to_i
        if is_ocupied?(selection) || selection > 8
          puts "Invalid position.Try again! "
          play_turn(player)
        else
          player.add_mark(selection)
          @board[selection] = player.marker
        end
  end

  def is_ocupied?(choice)
    @board[choice].eql?("X") || @board[choice].eql?("O")
  end   

end


newGame = Game.new()
newGame.play()






