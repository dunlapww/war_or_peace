class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      return :basic
    elsif @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      return :mutually_assured_destruction
    else
      return :war
    end
  end

  def winner
    return case self.type
      when :basic
        @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0) ? @player1 : @player2
      when :war
        @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2) ? @player1 : @player2
      when :mutually_assured_destruction
        "No Winner"
    end
  end

  def pile_cards

    if type == :basic
      @spoils_of_war << @player1.deck.remove_card
      @spoils_of_war << @player2.deck.remove_card
    else
      3.times do
        @spoils_of_war << @player1.deck.remove_card
        @spoils_of_war << @player2.deck.remove_card
      end
    end
    #remove any potential nils from spoils_of_war (due to player with low deck)
    @spoils_of_war = @spoils_of_war.grep(Card)

  end

  def award_spoils(winner)
    if winner == @player1 || winner == @player2
      winner.deck.cards.concat(@spoils_of_war)
    end
  end

end
