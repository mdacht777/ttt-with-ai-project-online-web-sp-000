class Game
  attr_accessor :board,:player_1,:player_2
  @board=[]
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  def initialize(player_1=Players::Human.new("X"),player_2=Players::Human.new("O"),board=Board.new)
    @player_1=player_1
    @player_2=player_2
    @board=board
  end
  def player_1=(a)
    @player_1=a
  end
  def player_2=(a)
    @player_2=a
  end
  def turn_count
    board.cells.count{|token| token == "X" || token == "O"}
  end
  def current_player
    # binding.pry
    turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
# binding.pry
    position_1 = board.cells[win_index_1] # load the value of the board at win_index_1
    position_2 = board.cells[win_index_2] # load the value of the board at win_index_2
    position_3 = board.cells[win_index_3] # load the value of the board at win_index_3
    if (position_1 == "X" || position_1== "O") && position_2 == position_1 && position_3 == position_1
      return win_combination # return the win_combination indexes that won.
  #    puts "Congratulations #{current_player}!"
      end
  end
  return false
  end

  def full?
  board.cells.each do |value|
    #puts value
    if value==" "
      return false
    end
  end
  return true
  end

  def draw?
    if won?
      return false
    else
        if !full?
          return false
        end
    end
    return true
  end

  def over?
  #  puts full?(board)
  #  puts won?(board)
    if won? && full?
      return true
    end
    if !full?
      if won?
        return true
      else
        return false
      end
    end
    if draw?
      return true
    end
    return false
  end

  def winner
    if won?
      board.cells[won?[0]]
    end
  end

  def turn
    board.display
    puts "#{current_player.token}'s turn!"
    input = current_player.move(board).to_i
    if board.valid_move?(input.to_s)
      puts "#{current_player.token} chooses #{input}!"
      board.update(input, current_player)
    elsif input.between?(1, 9) == false
      turn
    else
      turn
    end
  end

  def play
      while !over? and !draw?
        turn
      end
      # over?
      board.display
      if draw?
        puts "Cat's Game!"
      elsif won?
        puts "Congratulations #{winner}!"
      end
      puts "This game took #{board.turn_count} turns!"
    end
end
