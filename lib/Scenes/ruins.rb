require "./lib/Scenes/scene.rb"
require "./lib/Scenes/character_creation.rb"

class Ruins < Scene

  def initialize
    super
    @skeleton1 = Skeleton.new
    @skeleton2 = Skeleton.new
    @zombie = Zombie.new
    @skeleton1_alive = true
    @skeleton2_alive = true
    @zombie_alive = true
    @skeletons_encountered = false
    @campcount = 0
  end

  def zombie_fight
    while @zombie_alive == true
      $player.battle(@zombie)
      if @zombie.hp <= 0
        puts "You successfully kill the zombie, but in the ensuing chaos the campfire has been destroyed."
        @zombie_alive = false
      else
        puts "As you try to run, the zombie trips you"
        $player.hurt(3)
      end
    end
  end


  def inspect_crypt
    if @skeletons_encountered == false
      puts "You see a collection of bones and a few rusty weapons by the crypt."
    else
      if @skeleton2_alive == true
        puts "You see a skeleton guarding the crypt. It seems to be ignoring you for now."
      else
        puts "You see the crypt, with the bones of the skeletons laying broken everywhere."
      end
    end
  end

  def skeleton_encounter
    @skeletons_encountered = true
    if @skeleton1_alive == true
      puts "As you walk towards the crypt, several bones come together and form a skeleton. It starts approaching you menacingly."
      $player.battle(@skeleton1)
      if @skeleton1.hp <= 0
        @skeleton1_alive = false
        puts "As the skeleton dies, a second one rises and takes its place."
      else
        break
      end
    end
    if @skeleton2_alive == true
      $player.battle(@skeleton2)
      if @skeleton2.hp <= 0
        @skeleton2_alive = false
      end
    end
    if @skeleton1_alive == false && @skeleton2_alive == false
      puts "You see a passageway further into the crypt. Do you go down? (y/n)"
      print "\n>"
      decision = $stdin.gets.chomp
      if decision == 'y'
        go('down')
      else
        puts "You exit the crypt."
      end
    end
  end


  def start
    i=0
    while i==0
      puts "\nYou are in some spooky ruins. You see a path to the south. There is a campfire to your left, and a crypt to your right."
      choice = user_input
      puts "\n"
      if Lexicon.instance_variable_get(:@movements).include?(choice.verb) && Lexicon.instance_variable_get(:@directions).include?(choice.object)
        if choice.object == 'south'
          go('south')
        elsif choice.object == 'left'
          @campcount += 1
          if @campcount < 3
            puts "You rest by the campfire, and feel completely refreshed.\n"
            $player.heal(99)
          elsif @campcount == 3
            puts "You rest by the campfire..."
            $player.heal(3)
            puts "\nWhile you are resting, you are attacked by a zombie!"
            zombie_fight
          else
            puts "Your encounter with the zombie destroyed the campfire."
          end
        elsif choice.object == 'right'
          skeleton_encounter
        else
          puts "There is nothing of interest this way"
        end
      elsif Lexicon.instance_variable_get(:@inspects).include?(choice.verb) && (choice.object == 'crypt' || choice.object == 'right')
        inspect_crypt
      else
        puts "Invalid command."
      end
    end
  end

end

class Crypt < Scene

  def initialize
    super
    @bigskeleton = SkeletonBoss.new
  end

end
