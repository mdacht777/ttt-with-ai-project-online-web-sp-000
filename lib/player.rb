class Player
  attr_reader :token
  def initialize(token)
    @token=token
  end
end

class Players < Player
end
