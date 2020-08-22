require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Game
  attr_reader :whole_deck, :deck1, :deck2
  attr_accessor :player1, :player2

  # def initialize
  #   @whole_deck = nil
  #   @deck1 = nil
  #   @deck2 = nil
  #   @player1 = nil
  #   @player2 = nil
  #   @hand_winner = nil
  #   @hand_type = nil
  # end

  def get_standard_deck
    @whole_deck = Deck.new()
    @whole_deck.generate_standard_deck
  end

  def divide_deck(deck)
    half_of_deck_size = deck.cards.size / 2
    @deck1 = Deck.new(deck.cards.shift(half_of_deck_size))
    @deck2 = Deck.new(deck.cards)
  end

  def start_game_message
    "Welcome to War! (or Peace) This game will be played with 52 cards.\nThe players today are #{@player1.name} and #{@player2.name}.\nType 'GO' to start the game!\n"
  end

  def turn_note(hand_type, hand_winner, turn)
    if hand_type == :war
      return "WAR - #{hand_winner.name} won #{turn.spoils_of_war.size} cards\n"
    elsif hand_type == :mutually_assured_destruction
      return "*mutually assured destruction* #{turn.spoils_of_war.size} cards removed from play\n"
    else
      return "#{hand_winner.name} won #{turn.spoils_of_war.size} cards\n"
    end
  end

  def end_game_note(turn_count,hand_winner)
    if turn_count == 1000000
      return "---- DRAW ----"
    else
      return "*-*-*-* #{hand_winner.name} has won the game! *-*-*-*"
    end
  end


  def start

    get_standard_deck
    @whole_deck.cards.shuffle!
    divide_deck(@whole_deck)
    @player1 = Player.new("Alex",@deck1)
    @player2 = Player.new("Ghengis",@deck2)

    puts start_game_message

    until gets.chomp.upcase == "GO" do
      puts "Sorry, really need you to type that word 'go' to move forward..."
    end

    #game will be limited to 1,000,000 turns. initializing counter.
    turn_count = 0

    #take turns until someone has lost or turn_count is 1,000,000
    until @player1.has_lost? || @player2.has_lost? || turn_count == 1000000 do
      turn_count += 1
      turn = Turn.new(@player1,@player2)
      print "Turn #{turn_count}: " #print turn number

      #determine who is winner of this hand before removing cards from decks
      hand_type = turn.type
      hand_winner = turn.winner

      print " - Alex Deck: #{turn.player1.deck.cards.size}, Ghengis Deck: #{turn.player2.deck.cards.size} ---"

      #remove cards from deck based on turn type
      turn.pile_cards

      #print the outcome of the turn
      print turn_note(hand_type,hand_winner,turn)

      #give cards to winner of hand
      turn.award_spoils(hand_winner) if hand_type != :mutually_assured_destruction

    end #end until loop

    print end_game_note(turn_count, hand_winner)

  end
end
