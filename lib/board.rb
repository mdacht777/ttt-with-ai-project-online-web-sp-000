class Board
  attr_accessor :cells
  @cells=[]
  def initialize(board = nil)
    @cells = board
    self.reset!
  end

  def reset!
    @cells=Array.new(9, " ")
  end
  def turn_count
    @cells.count{|token| token == "X" || token == "O"}
  end
  def display
    $stdout.sync = true
    i=1
    puts "-------------"
    cells.each_with_index {|cell,index|
      print "|" if i==1
      if cell==" "
       print " #{index+1} |"
      else
        print " #{cell} |"
      end
      i+=1
      if i==4
        puts ""
        puts "-------------"
        i=1
      end
     }
    # puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    # puts "-----------"
    # puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    # puts "-----------"
    # puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end
# Define your WIN_COMBINATIONS constant
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

# code your input_to_index and move method here!
def input_to_index(input)
  input.to_i-1
end

def move(index,char)
  index=index.to_i
  @cells[index]=char
end

# code your #valid_move? method here
def valid_move?(index)
  index=index.to_i
  index.between?(1, 9) && !taken?(index)
end

def position(index)
  index=input_to_index(index)
  @cells[index]
end

def taken?(index)
  index=input_to_index(index)
  !(@cells[index].nil? || @cells[index] == " ")
end

def update(input,current_player)
  # puts "Please enter 1-9:"
  # # input = gets.strip
  # input = a
  index = input_to_index(input)
# binding.pry
  if valid_move?(input)
    move(index, current_player.token)
    # display
  # else
  #   Game.turn
  end
end

def won?
WIN_COMBINATIONS.each do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = @cells[win_index_1] # load the value of the board at win_index_1
  position_2 = @cells[win_index_2] # load the value of the board at win_index_2
  position_3 = @cells[win_index_3] # load the value of the board at win_index_3
  if (position_1 == "X" || position_1== "O") && position_2 == position_1 && position_3 == position_1
    return win_combination # return the win_combination indexes that won.
#    puts "Congratulations #{current_player}!"
    end
end
return false
end

def full?
@cells.each do |value|
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
    @cells[won?[0]]
  end
end

def play
  count=0
  while !over? && !draw? && count<=9
    turn
    count+=1
    puts count
  end
  if over?
    if draw?
      puts "Cat's Game!"
    else
      if won?
        puts "Congratulations #{winner}!"
      end
    end
  else
  end
end

end
