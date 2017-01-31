class Lexicon

    @directions = %w[down up left right forward back]
    @compass = %w[north south east west]
    @verbs = %w[stop eat jab poke prod gibberis]
    @inspects = %w[look inspect observe study enquire see check]
    @equips = %w[equip don wear wield]
    @grabs = %w[take grab loot]
    @throws = %w[throw hurl chuck lob]
    @movements = %w[go run walk stroll]
    @stop_words = %w[the in of from at it to]
    @nouns = %w[bear tree trees grass floor player crypt ibberis]
    @selfs = %w[me self myself]
    @weapons = %w[stick]
    @armors = %w[jerkin]
    @numbers = "[0-9]+"
    @fights = %w[fight attack hit stab slash kill whack smack kick punch slap battle]
    @flees = %w[flee escape run]

    @verbs.push(*@throws, *@movements, *@equips, *@grabs, *@inspects)
    @directions.push(*@compass)
    @nouns.push(*@weapons, *@armors, *@selfs)

  attr_reader :directions
  attr_reader :verbs
  attr_reader :throws
  attr_reader :movements
  attr_reader :stop_words
  attr_reader :nouns
  attr_reader :numbers
  attr_reader :fights
  attr_reader :flees

  def self.scan(input)

    sentence = []

    words = input.split

    words.each do |word|

      word_d = word.downcase

      if @directions.include? word_d
        sentence.push(['direction', word_d])
      elsif @verbs.include? word_d
        sentence.push(['verb', word_d])
      elsif @stop_words.include? word_d
        sentence.push(['stop', word_d])
      elsif @nouns.include? word_d
        sentence.push(['noun', word_d])
      elsif @fights.include? word_d
        sentence.push(['fight', word_d])
      elsif @flees.include? word_d
        sentence.push(['flee', word_d])
      elsif word.match(@numbers)
        sentence.push(['number', word.to_i])
      else
        sentence.push(['error', word_d])
      end
    end

  return sentence
  end
end
