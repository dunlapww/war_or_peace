require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class PlayerTest < Minitest::Test

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])


    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)
  end

  def test_turn_has_player1_and_player2
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
  end

  def test_spoils_of_war_defaults_as_empty_array
    assert_equal [], @turn.spoils_of_war
  end

  def test_turn_type
    assert_equal :basic, @turn.type
  end

  def test_turn_winner
    assert_equal @player1, @turn.winner
  end

  def test_pile_cards_and_spoils_of_war
    @turn.pile_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_award_spoils
    @turn.pile_cards
    @turn.award_spoils(@player1)
    assert_equal [@card2, @card5, @card8, @card1, @card3], @player1.deck.cards
  end



end
