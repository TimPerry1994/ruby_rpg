require_relative '../Characters/character.rb'
require "./lib/Scenes/scene.rb"
class CharacterCreation < Scene

  def start

  i = 0

  while i == 0
  hp = 10
  damage = 3
  defense = 3
  crit = 10

    puts "You are an adventurer, lost in the woods. What is your name?"
    print "\n>"
    name = $stdin.gets.chomp
    n=0
    puts "Before you started your adventure, what was your profession? (Enter a number)
            \n1: Blacksmith\n2: Outlaw\n3: Trader\n4: Thief\n5: Acrobat\n"
    while n<=0 || n>5
      print "\n>"
      n = $stdin.gets.chomp.to_i
      if n == 1
        hp += 2
        defense += 1
        damage += 1
      elsif n == 2
        damage += 2
        defense += 2
      elsif n == 4
        damage += 1
        crit += 20
      elsif n == 5
        crit += 10
        defense += 1
        hp += 1
      else
        puts "That is not a valid option."
      end
    end

    puts "Which of these words best describes you?
            \n1: Brave\n2: Aggressive\n3: Tough\n4: Mischievous\n5: Cowardly"
    m=0
    while m<=0 || m>5
      print "\n>"
      m = $stdin.gets.chomp.to_i
      if m == 1
        hp += 1
      elsif m == 2
        damage += 1
      elsif m == 3
        defense += 1
      elsif m == 4
        crit += 5
      elsif m == 5
        hp -= 1
        damage -= 1
        defense -= 1
        crit += 10
      else
        puts "That is not a valid option"
      end
    end

    hp.to_i
    damage.to_i
    defense.to_i
    crit.to_i

    puts "Your stats are as follows: \n\nName: #{name}\nHitpoints: #{hp}\nDamage: #{damage}\nDefense: #{defense}\nCritical Chance: #{crit}%\n\n"
    choice = "i"
    puts "Are you happy with these choices? (y/n)"
    while choice != "y" && choice != "n"
      print "\n>"
      choice = $stdin.gets.chomp
      if choice == "y"
        i = 1
      elsif choice == "n"
        i = 0
      else
        puts "That is not a valid option."

      end
    end
  end
  $player = Player.new(name, hp, damage, defense, crit)
  puts "You are now ready to start your adventure. Good luck!"
  go('west')
  puts go('west')
end
end
