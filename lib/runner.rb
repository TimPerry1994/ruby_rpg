require './lib/Scenes/scene.rb'
require './lib/Scenes/woods.rb'
require './lib/Scenes/character_creation.rb'

class Runner

  CharacterCreation.start
  wood = Woods.new
  wood.start

end
