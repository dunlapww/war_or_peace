require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Game

  def initialize
    @standard_deck = nil
    @deck1 = nil
    @deck2 = nil
    @player1 = nil
    @player2 = nil
    @hand_winner = nil
    @hand_type = nil
  end

  def get_standard_deck
    @standard_deck = Deck.new()
    @standard_deck.generate_standard_deck
  end

  def shuffle_deck
    @standard_deck.cards.shuffle!
  end

  def divide_deck
    half_of_deck = @standard_deck.cards.size / 2
    @deck1 = Deck.new(@standard_deck.cards.shift(half_of_deck))
    @deck2 = Deck.new(@standard_deck.cards)
  end

  def start_game_message
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are #{@player1.name} and #{@player2.name}."
    puts "Type 'GO' to start the game!"

    until gets.chomp.upcase == "GO" do
      puts "Sorry, really need you to type that word 'go' to move forward..."
    end
  end

  def play_game

    get_standard_deck
    shuffle_deck
    divide_deck
    @player1 = Player.new("Alex",@deck1)
    @player2 = Player.new("Ghengis",@deck2)

    start_game_message

    #game will be limited to 1,000,000 turns. initializing counter.
    turn_count = 0

    #take turns until someone has lost or turn_count is 1,000,000
    until @player1.has_lost? || @player2.has_lost? || turn_count == 1000000 do

      turn_count += 1
      turn = Turn.new(@player1,@player2)

      #determine who is winner of this hand before removing cards from decks
      @hand_type = turn.type
      @hand_winner = turn.winner

      print "Turn #{turn_count}: " #print turn number

      print " - Alex Deck: #{turn.player1.deck.cards.size}, Ghengis Deck: #{turn.player2.deck.cards.size} ---"

      #remove cards from deck based on turn type
      turn.pile_cards

      #print the outcome of the turn
      if @hand_type == :war
        print "WAR - #{@hand_winner.name} won #{turn.spoils_of_war.size} cards\n"
      elsif @hand_type == :mutually_assured_destruction
        print "*mutually assured destruction* #{turn.spoils_of_war.size} cards removed from play\n"
      else
        print "#{@hand_winner.name} won #{turn.spoils_of_war.size} cards\n"
      end

      #give cards to winner of hand
      turn.award_spoils(@hand_winner) if @hand_type != :mutually_assured_destruction


    end #end until loop

    if turn_count == 1000000
      print "---- DRAW ----"
    else
      print "*-*-*-* #{@hand_winner.name} has won the game! *-*-*-*"
    end

  end
end
