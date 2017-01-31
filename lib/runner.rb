require './lib/Scenes/scene.rb'
require './lib/Scenes/woods.rb'
require './lib/Scenes/character_creation.rb'
require './lib/Scenes/ruins.rb'

class Runner < Scene

    start = CharacterCreation.new
    woods = Woods.new
    ruins = Ruins.new
    crypt = Crypt.new

  start.add_paths({'west'=> woods})
  woods.add_paths({'north'=> ruins})
  ruins.add_paths({'south'=> woods, 'down'=> crypt})
  crypt.add_paths({'up'=> ruins})

  start.start

end
