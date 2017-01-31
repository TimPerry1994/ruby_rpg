require "./lib/Scenes/scene.rb"
require "./lib/Scenes/character_creation.rb"

class Woods < Scene

  def initialize
    @bear = Bear.new
    @bear_alive = true
    @stick_taken = false
    @direction_travelled = nil
    @bear_position = "center";
  end

  attr_reader :direction_travelled

  def throw_stick_scenario
    i = 0
    while i == 0
      puts "Which way do you throw the stick? (North, South, East, West)"
      choice = user_input_verb("throw")

      if Lexicon.instance_variable_get(:@compass).include?(choice)
        puts "You throw the stick to the #{choice}. The bear goes after it, revealing a leather jerkin it was sitting on. You pick it up"
        @bear_position = choice.downcase
        i = 1
      else
        puts "That is not a valid direction"
      end
    end
  end

  def bear_fight
    $player.battle(@bear)
    if @bear.hp <= 0
      @bear_alive = false
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

      elsif Lexicon.instance_variable_get(:@throws).include?(choice.verb) && choice.object == 'stick'

        if @bear_alive == true
          throw_stick_scenario
        else
          puts "You throw the stick far away. You feel a pang of regret as you will never see another stick so perfect."
        end

      elsif Lexicon.instance_variable_get(:@compass).include?(choice.object)
        if choice.object == @bear_position
          puts "You run into the bear."
          bear_fight
        else
          @direction_traveled = choice.object
          dead("You go #{@direction_traveled}, and decide to call it a day.")
        end

      else
        puts "You don't think that's a good idea."
      end
    end
  end

end
