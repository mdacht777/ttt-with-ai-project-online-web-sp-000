module Players
  class Human < Player
    def move(a)
      puts "Please enter 1-9:"
      gets.chomp
    end
  end
  class Computer < Player
    def move(a)
      "2"
    end
  end
end
