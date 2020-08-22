require 'minitest/autorun'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_get_standard_deck
    game = Game.new()
    game.get_standard_deck

    assert_equal 52, game.whole_deck.cards.size
  end

  def test_divide_deck
    game = Game.new()
    game.get_standard_deck
    game.divide_deck(game.whole_deck)

    assert_equal 26, game.deck1.cards.size
    assert_equal 26, game.deck1.cards.size
  end

  def test_start_game_message
    game = Game.new()
    game.get_standard_deck
    game.divide_deck(game.whole_deck)
    game.player1 = Player.new("Alex",game.deck1)
    game.player2 = Player.new("Sally",game.deck2)

    assert_equal "Welcome to War! (or Peace) This game will be played with 52 cards.\nThe players today are Alex and Sally.\nType 'GO' to start the game!\n", game.start_game_message
  end

  def test_print_turn_note
    game = Game.new()
    game.get_standard_deck
    game.divide_deck(game.whole_deck)
    game.player1 = Player.new("Alex",game.deck1)
    game.player2 = Player.new("Sally",game.deck2)

    turn = Turn.new(game.player1, game.player2)
    hand_winner = game.player1
    hand_type = :war
    turn.pile_cards

    assert_equal "WAR - Alex won #{turn.spoils_of_war.size} cards\n", game.turn_note(hand_type, hand_winner, turn)

    turn = Turn.new(game.player1, game.player2)
    hand_winner = game.player2
    hand_type = :mutually_assured_destruction
    turn.pile_cards

    assert_equal "*mutually assured destruction* #{turn.spoils_of_war.size} cards removed from play\n", game.turn_note(hand_type, hand_winner, turn)

    turn = Turn.new(game.player1, game.player2)
    hand_winner = game.player2
    hand_type = :basic
    turn.pile_cards

    assert_equal "Sally won #{turn.spoils_of_war.size} cards\n", game.turn_note(hand_type, hand_winner, turn)

  end

  def test_end_game_note
    game = Game.new()
    game.get_standard_deck
    hand_winner = Player.new("Alex",game.whole_deck)

    turn_count = 1000000
    assert_equal "---- DRAW ----", game.end_game_note(turn_count,hand_winner)

    turn_count = 700
    assert_equal "*-*-*-* #{hand_winner.name} has won the game! *-*-*-*", game.end_game_note(turn_count, hand_winner)
  end

end
