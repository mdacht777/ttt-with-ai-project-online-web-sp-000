module Players
  class Human < Player
    def move(a)
      puts "Please enter 1-9:"
      gets.chomp
    end
  end
  class Computer < Player
    def move(a)
# puts a.cells.find {|cell| cell=="X"}
# gets
      i=(1..9).to_a.sample.to_s
      if a.taken?(i)
        move(a)
      else
        i
      end
    end
  end
end
