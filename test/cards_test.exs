defmodule CardsTest do
  use ExUnit.Case
  doctest Cards # with this line we said that we want to run docs tests

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Create a deck of 20 cards" do
    deck_length =  length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
    deck =  Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
