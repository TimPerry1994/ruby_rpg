class Weapon

  def initialize
    @str = 0
    @crit = 0
    @inventory = false
  end

  attr_reader :str

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
  end
end
