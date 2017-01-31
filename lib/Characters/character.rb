require_relative '../Equipment/weapons.rb'
require_relative '../Equipment/armors.rb'

class Character

  @special = false

  def initialize(name, hp, damag, defense, crit)
    @name = name
    @hp = hp
    @hpmax = hp
    @damage = damag
    @defense = defense
    @crit = crit
  end

  attr_accessor :name
  attr_accessor :hp
  attr_accessor :damage
  attr_accessor :defense
  attr_accessor :crit
  attr_accessor :hpmax

  def attack(character)
    #Attack an enemy
    luck = rand(100)
    hit = @damage
    puts "#{@name} strikes at #{character.name}..."
    if luck < @crit
      hit = hit*1.5
      puts "Critical hit!"
    else
      hit = hit
    end
    character.hurt(hit)
  end

  def hurt(number)
    total = number - (@defense/2)
    @hp -= total.to_i
    if hp >= 0
      puts "#{@name} is hit for #{total.to_i} damage. #{@name} has #{@hp} health remaining.\n\n"
    else
      puts "#{@name} is hit for #{total.to_i} damage. #{@name} is killed.\n\n"
    end
  end

  def heal(number)
    @hp += number
    if @hp > @hpmax
      @hp = @hpmax
    end
    puts "#{@name} is healed for #{number} points. They have #{@hp} health remaining."
  end

  def set_hp(number)
    @hp = number
  end

end

class Player < Character

  @weapon = nil
  @armor = nil


  def dead(reason)
    puts "\n#{reason} \nGame Over."
    exit(0)
  end

  def battle(enemy)

    puts "You have encountered #{enemy.name}."
    while self.hp > 0 && enemy.hp > 0

      puts "Will you fight or flee?"
      print "\n>"
      choice = $stdin.gets.chomp
      if Lexicon.instance_variable_get(:@fights).include?(choice)
        self.attack(enemy)
      elsif Lexicon.instance_variable_get(:@flees).include?(choice)
        puts "You run away from the battle."
        break
      else
        puts "Invalid command, lose your turn!"
      end
      if enemy.hp <=0
        break
      else
        enemy.attack(self)
      end
      if self.hp <=0
        self.dead("You have been killed in battle.")
      end
    end
  end

  def equip_weapon(weapon)
    if weapon == @weapon
      puts "That is already equipped."
    elsif weapon.instance_variable_get(:@inventory) == true
      puts "You equip the weapon, it has #{weapon.instance_variable_get(:@str)} damage and an extra #{weapon.instance_variable_get(:@crit)}% critical chance"
      self.crit += weapon.instance_variable_get(:@crit)
      self.damage += weapon.instance_variable_get(:@str)
      if @weapon != nil
        self.unequip_weapon(@weapon)
      end
      @weapon = weapon
    else
      puts "You cannot equip that."
    end
  end

  def equip_armor(armor)
    if armor == @armor
      puts "That is already equipped."
    elsif armor.instance_variable_get(:@inventory) == true
      puts "You equip the armor, it has #{armor.instance_variable_get(:@def)} damage and an extra #{armor.instance_variable_get(:@hp)} hp"

      self.defense += armor.instance_variable_get(:@def)
      self.hpmax += armor.instance_variable_get(:@hp)
      self.hp += armor.instance_variable_get(:@hp)
      if @armor != nil
        self.unequip_armor(@armor)
      end
      @armor = armor
    else
      puts "You cannot equip that."
    end
  end

  def unequip_weapon(weapon)
    if weapon == @weapon
      self.damage -= @weapon.instance_variable_get(:@str)
      self.crit -= @weapon.instance_variable_get(:@crit)
      @weapon = nil
    else
      puts " "
    end
  end

  def unequip_armor(armor)
    if armor == @armor
      self.defense -= @armor.instance_variable_get(:@def)
      self.hpmax -= @armor.instance_variable_get(:@hp)
      self.hp -= @armor.instance_variable_get(:@hp)
      if self.hp <= 0
        self.hp = 1
      end
    else
      puts " "
    end
  end

end

class Bear < Character

  def initialize
    @name = "Bear"
    @hp = 20
    @damage = 5
    @defense = 2
    @crit = 20
    @bite_used == false
  end

  attr_accessor :bite_used

  def check_special
    if self.hp < 10 && self.bite_used == false
      return true
    else
      return false
    end
  end

  def bite(player)
    puts "The bear is enraged!"
    @damage = 8
    @crit = 40
    self.attack(player)
    @bite_used = true
    puts "The bear has calmed down..."
  end

end
