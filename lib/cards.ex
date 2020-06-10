defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    for suit <- suits do
      #return an array like map
      for value <- values do
        "#{value} of #{suit}"
      end
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(card, deck) do
    Enum.member?(deck, card)
  end
end
