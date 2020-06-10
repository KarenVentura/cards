defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    cards = for suit <- suits do
      #return an array like map
      for value <- values do
        "#{value} of #{suit}"
      end
    end

    #flatten method from List module
    List.flatten(cards)

    #another way better option
    for suit <- suits, value <- values do #double loop
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(card, deck) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size) 
    # this method split is returning a Tuple {  *hand*, *deck* } in ruby it will be { hand: [], deck: [] }
    #returns a tuple, in ruby we call it Hash, but a tuple does not have a key name, just the values  
  end

  def save(deck, filename) do
    #method to use earlang code, remember that Elixir transpile to Earlang and it is compiled by BEAM virtual machine
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
    # { status, binary } = File.read('my_deck_file') //pattern matching to assing values in case of read the file
    # in this case binary variable has the binaries code from file
    # we can execute :erlang.binary_to_term(binary) to get the deck_file text
  end

  def load(filename) do
    { status, binary } = File.read(filename)

    # in case the filename does not exist the status variable is going to be :error instead of :ok
    # in Elixir we can do the following
    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "That file does not exist"
    end
  end
end
