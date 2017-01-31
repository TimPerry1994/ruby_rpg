class Armor

  def initialize
    @def = 0
    @hp = 0
    @inventory = false
    @name = nil
  end

  attr_reader :def
  attr_reader :hp
  attr_reader :name
  attr_accessor :inventory

end

class LeatherJerkin < Armor

  def initialize
    @def = 2
    @hp = 1
    @inventory = false
    @name = 'leather_jerkin'
  end
end
