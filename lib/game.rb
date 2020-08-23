require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Game
  attr_reader :whole_deck, :deck1, :deck2
  attr_accessor :player1, :player2

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

    #create a standard deck of 52 cards
    whole_deck = Deck.new()
    whole_deck.generate_standard_deck

    #shuffle the deck
    whole_deck.cards.shuffle!

    #divide deck in half
    half_of_deck_size = whole_deck.cards.size / 2
    deck1 = Deck.new(whole_deck.cards.shift(half_of_deck_size))
    deck2 = Deck.new(whole_deck.cards)

    #create two players
    print "Enter player1 name [Alex]: "
    player1_name = gets
    player1_name = "Alex" if player1_name == "\n"
    player1 = Player.new(player1_name.chomp.capitalize,deck1)

    print "Enter player2 name [Ghengis]: "
    player2_name = gets
    player2_name = "Ghengis" if player2_name == "\n"
    player2 = Player.new(player2_name.chomp.capitalize,deck2)

    #print start of game message to screen
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are #{player1.name} and #{player2.name}."
    puts "Type 'GO' to start the game!"

    #require user to type go to begin game
    until gets.chomp.upcase == "GO" do
      puts "Sorry, really need you to type that word 'go' to move forward..."
    end

    #game will be limited to 1,000,000 turns. initializing counter.
    turn_count = 0

    #take turns until someone has lost or turn_count is 1,000,000
    until player1.has_lost? || player2.has_lost? || turn_count == 1000000 do
      turn_count += 1
      turn = Turn.new(player1,player2)
      print "Turn #{turn_count}: "

      #determine who is winner of this hand before removing cards from decks
      hand_type = turn.type
      hand_winner = turn.winner
      if hand_type == :mutually_assured_destruction
        require "pry"; binding.pry
      end
      #remove cards from deck
      turn.pile_cards

      #print winner of the turn and cards received
      print turn_note(hand_type,hand_winner,turn)

      #give cards to winner of hand
      turn.award_spoils(hand_winner) if hand_type != :mutually_assured_destruction

    end #end until loop

    #print end game message
    print end_game_note(turn_count, hand_winner)

  end
end
