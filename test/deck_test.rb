require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)

    @cards = [@card1, @card2, @card3]

    @deck = Deck.new(@cards)
  end

  def test_deck_has_default_of_no_cards
    deck = Deck.new()
    assert_equal [], deck.cards
  end

  def test_deck_can_contain_cards
    assert_equal @cards, @deck.cards
  end

  def test_rank_of_card_at
    assert_equal 12, @deck.rank_of_card_at(0)
    assert_equal 14, @deck.rank_of_card_at(2)
    assert_equal 0, @deck.rank_of_card_at(99)
  end

  def test_high_ranking_cards
    assert_equal [@card1, @card3], @deck.high_ranking_cards
  end

  def test_percent_high_ranking
    assert_equal 66.67, @deck.percent_high_ranking
  end

  def test_remove_card

    assert_equal @card1, @deck.remove_card
    assert_equal @card2, @deck.remove_card
    assert_equal @card3, @deck.remove_card
    assert_equal [], @deck.cards
    assert_nil @deck.remove_card
  end


  def test_remove_add_and_high_ranking

    assert_equal @card1, @deck.remove_card
    assert_equal [@card2, @card3], @deck.cards
    assert_equal 50.0, @deck.percent_high_ranking

    card4 = Card.new(:club, '5', 5)
    @deck.add_card(card4)

    assert_equal [@card2, @card3, card4], @deck.cards
    assert_equal [@card3], @deck.high_ranking_cards
    assert_equal 33.33, @deck.percent_high_ranking

  end

  def test_generate_standard_deck
    test_deck = Deck.new()
    test_deck.generate_standard_deck

    deck_details = test_deck.cards.map do |card|
      "#{card.value} of #{card.suit.to_s} (#{card.rank})"
    end.sort

    assert_equal [
      "10 of clubs (10)",
      "10 of diamonds (10)",
      "10 of hearts (10)",
      "10 of spaids (10)",
      "2 of clubs (2)",
      "2 of diamonds (2)",
      "2 of hearts (2)",
      "2 of spaids (2)",
      "3 of clubs (3)",
      "3 of diamonds (3)",
      "3 of hearts (3)",
      "3 of spaids (3)",
      "4 of clubs (4)",
      "4 of diamonds (4)",
      "4 of hearts (4)",
      "4 of spaids (4)",
      "5 of clubs (5)",
      "5 of diamonds (5)",
      "5 of hearts (5)",
      "5 of spaids (5)",
      "6 of clubs (6)",
      "6 of diamonds (6)",
      "6 of hearts (6)",
      "6 of spaids (6)",
      "7 of clubs (7)",
      "7 of diamonds (7)",
      "7 of hearts (7)",
      "7 of spaids (7)",
      "8 of clubs (8)",
      "8 of diamonds (8)",
      "8 of hearts (8)",
      "8 of spaids (8)",
      "9 of clubs (9)",
      "9 of diamonds (9)",
      "9 of hearts (9)",
      "9 of spaids (9)",
      "Ace of clubs (14)",
      "Ace of diamonds (14)",
      "Ace of hearts (14)",
      "Ace of spaids (14)",
      "Jack of clubs (11)",
      "Jack of diamonds (11)",
      "Jack of hearts (11)",
      "Jack of spaids (11)",
      "King of clubs (13)",
      "King of diamonds (13)",
      "King of hearts (13)",
      "King of spaids (13)",
      "Queen of clubs (12)",
      "Queen of diamonds (12)",
      "Queen of hearts (12)",
      "Queen of spaids (12)"
     ], deck_details

  end
end
