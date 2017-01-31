class Weapon

  def initialize
    @str = 0
    @crit = 0
    @inventory = false
    @name = nil
  end

  attr_reader :str
  attr_reader :crit
  attr_reader :name
  attr_accessor :inventory

  def pick_up
    @inventory = true
  end

  def drop
    @inventory = false
  end
end

class WoodenStick < Weapon
  def initialize
    @str = 2
    @crit = 0
    inventory = false
    @name = 'stick'
  end
end
