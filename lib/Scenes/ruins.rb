require "./lib/Scenes/scene.rb"
require "./lib/Scenes/character_creation.rb"

class Ruins < Scene

  def initialize
    super
    @skeleton1 = Skeleton.new
    @skeleton2 = Skeleton.new
    @zombie = Zombie.new
  end

  def start
    puts "You are in some spooky ruins. You see a path to the south."
    choice = user_input
    if Lexicon.instance_variable_get(:@movements).include?(choice.verb) && Lexicon.instance_variable_get(:@compass).include?(choice.object)
      if choice.object == 'south'
        go('south')
      else
        puts "There is nothing of interest this way"
      end
    else
      puts "Under construction, try going south again."
    end
  end

end

class Crypt < Scene

  def initialize
    super
    @bigskeleton = SkeletonBoss.new
  end

end
