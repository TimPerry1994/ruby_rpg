require "./lib/Scenes/scene.rb"
require "./lib/Scenes/character_creation.rb"

class Woods < Scene

  def initialize
    @bear = Bear.new
    @stick = WoodenStick.new
    @bear_alive = true
    @stick_taken = false
    @direction_travelled = nil
    @bear_position = "center";
  end

  attr_reader :direction_travelled

  def stick_scenario(verb)
    if Lexicon.instance_variable_get(:@throws).include?(verb)
      $player.unequip_weapon(@stick)
      @stick.inventory = false
      if @bear_alive == true && @bear_position != 'center'
        bear_fight
      elsif @bear_alive == true
        throw_stick_scenario
      else
        puts "You throw the stick away. It doesn't go far."
        @stick_taken = false
      end

    elsif Lexicon.instance_variable_get(:@grabs).include?(verb)
      if @bear_position != "center" && @bear_alive == true
        bear_fight
      else
        @stick.inventory = true
        @stick_taken = true
      end

    elsif Lexicon.instance_variable_get(:@equips).include?(verb)
      if @bear_position != "center" && @bear_alive == true && @stick.inventory == false
        bear_fight
      else
        @stick.inventory = true
        $player.equip_weapon(@stick)
        @stick_taken = true
      end
    else
      puts "You don't want to do that with the stick"
    end
  end


  def throw_stick_scenario
    i = 0
    while i == 0
      puts "Which way do you throw the stick? (North, South, East, West)"
      choice = user_input_verb("throw")

      if Lexicon.instance_variable_get(:@compass).include?(choice)
        puts "You throw the stick to the #{choice}. The bear goes after it, revealing a leather jerkin it was sitting on. You pick it up"
        @bear_position = choice.downcase
        @stick_taken = true
        $player.unequip_weapon(@stick)
        @stick.inventory = false
        i = 1
      else
        puts "That is not a valid direction"
      end
    end
  end

  def bear_fight
    if @bear_alive == true
      $player.battle(@bear)
      if @bear.hp <= 0
        @bear_alive = false
      end
    else
      puts "It's already dead, what more do you want from it?"
    end
  end

  def start

    i = 0

    while i == 0
      situation =  ["You are in a clearing in the forest."]

      if @bear_alive == true
        situation.push("In the #{@bear_position} you see a bear.")
      end
      if @stick_taken == false
        situation.push ("Beside you is a decent sized stick.")
      end

      puts situation
      choice = user_input

      if Lexicon.instance_variable_get(:@fights).include?(choice.verb) && choice.object == 'bear'

        bear_fight

      elsif choice.object == 'stick'

        stick_scenario(choice.verb)

      elsif Lexicon.instance_variable_get(:@compass).include?(choice.object)
        if choice.object == @bear_position
          puts "You run into the bear."
          bear_fight
        else
          @direction_traveled = choice.object
          dead("You go #{@direction_traveled}, and decide to call it a day. (No areas have been developed beyond this point)")
        end

      else
        puts "You don't think that's a good idea."
      end
    end
  end

end
