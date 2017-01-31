require "./lib/lexicon.rb"
require "./lib/parser.rb"
require "./lib/Characters/character.rb"

class Scene

  def user_input
    begin
      print "\n>"
      input = $stdin.gets.chomp
      lex = Lexicon.scan(input)
      output = Parser.parse_sentence(lex)
    rescue ParserError=>e
      puts "Error: #{e}"
      lex = Lexicon.scan('ibberis gibberis ibberis')
      output = Parser.parse_sentence(lex)
    else
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

end
