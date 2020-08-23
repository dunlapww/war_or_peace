require 'minitest/autorun'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_turn_note

    game = Game.new()
    deck = Deck.new()
    deck.generate_standard_deck

    player1 = Player.new("Alex",deck)
    player2 = Player.new("Sally",deck)

    turn = Turn.new(player1, player2)
    hand_winner = player1
    turn.pile_cards

    hand_type = :war
    assert_equal "WAR - #{hand_winner.name} won #{turn.spoils_of_war.size} cards\n",
    game.turn_note(hand_type, hand_winner, turn)


    hand_type = :mutually_assured_destruction
    assert_equal "*mutually assured destruction* #{turn.spoils_of_war.size} cards removed from play\n", game.turn_note(hand_type, hand_winner, turn)

    hand_type = :basic
    assert_equal "#{hand_winner.name} won #{turn.spoils_of_war.size} cards\n", game.turn_note(hand_type, hand_winner, turn)

  end

  def test_end_game_note
    game = Game.new()
    full_deck = Deck.new()
    full_deck.generate_standard_deck
    empty_deck = Deck.new()

    player1 = Player.new("Alex",full_deck)
    player2 = Player.new("Sally",empty_deck)

    turn_count = 1000000
    assert_equal "---- DRAW ----", game.end_game_note(turn_count,player1, player2)

    turn_count = 700
    assert_equal "*-*-*-* Alex has won the game! *-*-*-*", game.end_game_note(turn_count, player1, player2)

  end

end
