require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'

class PlayerTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)

    @cards = [@card1, @card2, @card3]

    @deck = Deck.new(@cards)

    @player = Player.new('Clarisa', @deck)
  end

  def test_player_has_a_name
    assert_equal 'Clarisa', @player.name
  end

  def test_player_has_a_deck
    assert_equal @deck, @player.deck
  end

  def test_player_has_lost?
    deck = Deck.new(@cards)
    player = Player.new("Harry",deck)
    refute player.has_lost?

    deck = Deck.new()
    player2 = Player.new("Sally",deck)
    assert player2.has_lost?
  end

  def test_player_has_lost_only_when_no_more_cards
    assert_equal @card1, @player.deck.remove_card
    refute @player.has_lost?
    assert_equal @card2, @player.deck.remove_card
    refute @player.has_lost?
    assert_equal @card3, @player.deck.remove_card
    assert @player.has_lost?
    assert_equal [],@player.deck.cards
  end

end
