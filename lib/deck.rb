class Deck
  attr_reader :cards

  #initialize takes an array of Cards
  def initialize(cards = [])
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].nil? ? 0 : @cards[index].rank
  end

  def high_ranking_cards
    @cards.select {|card| card.rank >= 11}
  end

  def percent_high_ranking
    ((high_ranking_cards.size.to_f/@cards.size)*100).round(2)
  end

  def remove_card
    @cards.shift
  end

  def add_card(card)
    @cards.push(card)
  end

  def generate_standard_deck
    card_suits        = [:hearts, :clubs, :diamonds, :spaids]
    card_values_ranks = {
      "2"    =>2,
      "3"    =>3,
      "4"    =>4,
      "5"    =>5,
      "6"    =>6,
      "7"    =>7,
      "8"    =>8,
      "9"    =>9,
      "10"   =>10,
      "Jack" =>11,
      "Queen"=>12,
      "King" =>13,
      "Ace"  =>14
    }

    @cards = []
    card_suits.each do |suit|
      card_values_ranks.each do |value,rank|
        @cards << Card.new(suit,value,rank)
      end
    end

  end

end
