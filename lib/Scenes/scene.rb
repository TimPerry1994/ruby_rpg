require "./lib/lexicon.rb"
require "./lib/parser.rb"
require "./lib/Characters/character.rb"
require "./lib/Equipment/weapons.rb"
require "./lib/Equipment/armors.rb"

class Scene

  def initialize
    @paths = {}
    @@stick = WoodenStick.new
    @@jerkin = LeatherJerkin.new
  end

  attr_reader :paths

  def user_input
    begin
      print "\n>"
      input = $stdin.gets.chomp
      lex = Lexicon.scan(input)
      output = Parser.parse_sentence(lex)
    rescue ParserError=>e
      puts "Error: #{e}"
      lex = Lexicon.scan('gibberis ibberis')
      output = Parser.parse_sentence(lex)
    else

      if Lexicon.instance_variable_get(:@inspects).include?(output.verb) && Lexicon.instance_variable_get(:@selfs).include?(output.object)
        puts "\nName: #{$player.name}\nCurrent hp: #{$player.hp}\nMax hp: #{$player.hpmax}\nDamage: #{$player.damage}
Defense: #{$player.defense}\nCritical Chance: #{$player.crit}%\nWeapon: #{$player.get_weapon}
Armor: #{$player.get_armor}\n\n"
      end

      return output
    end
  end

  def user_input_verb(verb)
    begin
      print "\n>"
      input = $stdin.gets.chomp
      lex = Lexicon.scan("#{verb} #{input}")
      output = Parser.parse_sentence(lex)
    rescue ParserError=>e
      puts "Error: #{e}"
      lex = Lexicon.scan('ibberis gibberis ibberis')
      output = Parser.parse_sentence(lex)
    else
      return output.object
    end
  end

  def go(direction)
    @paths[direction].start
  end

  def add_paths(paths)
    @paths.update(paths)
  end



end
