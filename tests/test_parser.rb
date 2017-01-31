require './lib/lexicon.rb'
require './lib/parser.rb'
require "test/unit"

class TestParser < Test::Unit::TestCase

  def test_peek()
    assert_equal(Parser.peek([['stop', 'the'], ['verb','go']]), "stop")
    result = Parser.peek([['noun', 'bear'], ['verb', 'eats'], ['stop', 'the'],['noun', 'honey']])
    assert_equal("noun", result)
  end

  def test_match()
    assert_equal(Parser.match([['stop', 'the'], ['verb','go']], 'stop'), ['stop', 'the'])
    result = Parser.match([['noun', 'bear'], ['verb', 'eats'], ['stop', 'the'],['noun', 'honey']], 'noun')
    assert_equal(result, ['noun', 'bear'])
    assert_equal(nil, Parser.match([['noun', 'bear'], ['direction', 'north']], 'verb'))
    assert_equal(nil, Parser.match([['noun', 'bear'], ['direction', 'north']], 'direction'))
  end

  def test_skip()
    assert_equal(nil, Parser.skip([['noun', 'bear'], ['stop', 'the']], 'stop'))
    assert_equal(nil, Parser.skip([['noun', 'bear'], ['stop', 'the']], 'noun'))
    assert_equal(nil, Parser.skip([['noun', 'bear'], ['stop', 'the']], 'verb'))
  end

  def test_parse_verb()
      assert_equal(['verb', 'eats'], Parser.parse_verb([['stop', 'it'], ['verb', 'eats'], ['noun', 'honey']]))
      assert_raise ParserError do
        Parser.parse_verb([['stop', 'the'], ['noun', 'bear'], ['verb', 'eats']])
      end
  end

  def test_parse_object()
    assert_equal(['noun', 'bear'], Parser.parse_object([['stop', 'the'], ['noun', 'bear'], ['verb', 'eats']]))
    assert_equal(['direction', 'north'], Parser.parse_object([['stop', 'the'], ['direction', 'north'], ['verb', 'remembers']]))
    assert_raise ParserError do
      Parser.parse_object([['stop', 'it'], ['verb', 'eats'], ['noun', 'honey']])
    end
  end

  def test_parse_subject()
    assert_equal(['noun', 'bear'], Parser.parse_subject([['stop', 'the'], ['noun', 'bear'], ['verb', 'eats']]))
    assert_equal(['noun', 'player'], Parser.parse_subject([['verb', 'attack'], ['stop', 'the'], ['noun', 'bear']]))
    assert_raise ParserError do
      Parser.parse_subject([['stop', 'the'], ['direction', 'north'], ['verb', 'remembers']])
    end
  end

  def test_parse_battle()
    assert_equal(['fight', 'attack'], Parser.parse_battle([['fight', 'attack'], ['noun', 'bear']]))
    assert_equal(['flee','run'], Parser.parse_battle([['flee', 'run'], ['stop', 'from'], ['noun', 'bear']]))
    assert_raise ParserError do
      Parser.parse_battle([['verb', 'eat'], ['noun', 'bear']])
    end
  end


  def test_parse_sentence()
    sentence = Parser.parse_sentence([['stop', 'the'], ['noun', 'bear'], ['verb','eats'], ['number', 3], ['noun', 'honey']])
    assert_equal("bear", sentence.subject)
    assert_equal("eats", sentence.verb)
    assert_equal(3, sentence.number)
    assert_equal("honey", sentence.object)


    movement = Parser.parse_sentence([['verb', 'go'], ['direction', 'down'], ['stop', 'the'], ['noun', 'hole']])
    assert_equal("player", movement.subject)
    assert_equal("go", movement.verb)
    assert_equal(1, movement.number)
    assert_equal("down", movement.object)
  end

end
