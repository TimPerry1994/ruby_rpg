require './lib/Characters/character.rb'
require "test/unit"

class TestLexicon < Test::Unit::TestCase

  def test_stats()
    char = Character.new("Jeff", 100, 4, 3, 5)
    assert_equal(char.hp, 100)
    assert_equal(char.name, "Jeff")
    assert_equal(char.damage, 4)
    assert_equal(char.defense, 3)
    assert_equal(char.crit, 5)
  end

  def test_attack()
    char = Character.new("Jeff", 100, 4, 0, 0)
    bear = Character.new("Jeff", 100, 4, 0, 0)
    char.attack(bear)
    assert_equal(bear.hp, 96)
  end

  def test_heal()
    char = Character.new("Jeff", 100, 4, 0, 0)
    char.set_hp(95)
    char.heal(4)
    assert_equal(char.hp, 99)
    char.heal(4)
    assert_equal(char.hp, 100)
  end


end
