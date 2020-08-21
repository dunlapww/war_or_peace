require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

#variables to setup a standard deck of 52 cards
card_suits        = [:hearts, :clubs, :diamonds, :spaids]
card_values_ranks = {
  "2,"    =>2,
  "3,"    =>3,
  "4,"    =>4,
  "5,"    =>5,
  "6,"    =>6,
  "7,"    =>7,
  "8,"    =>8,
  "9,"    =>9,
  "10,"   =>10,
  "Jack," =>11,
  "Queen,"=>12,
  "King," =>13,
  "Ace"   =>14
}

#create standard deck of 52 cards
standard_deck = Deck.new()
standard_deck = standard_deck.generate_standard_deck
# standard_deck = []
# card_suits.each do |suit|
#   card_values_ranks.each do |value,rank|
#     full_deck << Card.new(suit,value,rank)
#   end
# end

#shuffle the cards
standard_deck.shuffle!

#divide the 52 card deck into equal decks
deck1 = Deck.new(standard_deck.shift(26))
deck2 = Deck.new(standard_deck)

#setup two players, each with a deck
player1 = Player.new("Alex",deck1)
player2 = Player.new("Ghengis",deck2)

#setup a new game
game = Game.new(player1,player2)

#play the game
game.start
