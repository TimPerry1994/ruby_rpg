class ParserError < Exception
end

class Sentence

  def initialize(subj, verb, numb, obj)

    @subject = subj[1]
    @verb = verb[1]
    @number = numb[1]
    @object = obj[1]

  end

  attr_reader :subject
  attr_reader :verb
  attr_reader :object
  attr_reader :number

end

class Parser
  def self.peek(word_list)

    if word_list
      word = word_list[0]
      return word[0]
    else
      return nil
    end
  end

  def self.match(word_list, expecting)
    if word_list
      word = word_list.shift

      if word[0] == expecting
        return word
      else
        return nil
      end
    else
      return nil
    end
  end

  def self.skip(word_list, word_type)
    while peek(word_list) == word_type
      match(word_list, word_type)
    end
  end

  def self.parse_verb(word_list)
    skip(word_list, 'stop')
    if peek(word_list) == 'verb'
      return match(word_list, 'verb')
    elsif peek(word_list) == 'fight'
      return match(word_list, 'fight')
    else
      raise ParserError.new("Expected a verb next")
      return ['error','verb']
    end
  end

  def self.parse_object(word_list)
    skip(word_list, 'stop')
    next_word = peek(word_list)

    if next_word == 'noun'
      return match(word_list, 'noun')
    elsif next_word == 'direction'
      return match(word_list, 'direction')
    else
      raise ParserError.new("Expected an object next")
      return ['error', 'noun']
    end
  end

  def self.parse_subject(word_list)
    skip(word_list, 'stop')
    next_word = peek(word_list)

    return ['player', 'noun']

  end

  def self.parse_number(word_list)
    Parser.skip(word_list, 'stop')

    if Parser.peek(word_list) == 'number'
      return Parser.match(word_list, 'number')
    else
      return ['number', 1]
    end
  end

  def self.parse_battle(word_list)

    if Parser.peek(word_list) == 'fight'
      return Parser.match(word_list, 'fight')
    elsif Parser.peek(word_list) == 'flee'
      return Parser.match(word_list, 'flee')
    else
      raise ParserError.new("That is not a valid command")
    end
  end

  def self.parse_sentence(word_list)
    subj = parse_subject(word_list)
    verb = parse_verb(word_list)
    numb = parse_number(word_list)
    obj = parse_object(word_list)

    return Sentence.new(subj, verb, numb, obj)
  end
end
