defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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

  @doc """
    Determines wheter a deck contains a given card

  ## Examples

  
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of deck. The
    `hand_size` argument indicates how many cards should be in the hand

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size) 
    # this method "split" is returning a Tuple {  *hand*, *deck* } in ruby it will be { hand: [], deck: [] }
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

  def load_pm(filename) do
    # in this case we are using pattern matching to assign and compare at the same time
    # case is reciving the statement and it should return 2 values
    # in the second statement we are using pattern matching to assign values and comparing
    # in case of reason variable, we are not using that varible then elixir throw a warning but with _ we said it isn't going to be used
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # with |> operator the result of the functions is passed to the next ones
    # for example, the deck returned of function create_deck is going to be passed automatically to function suffle
    # shuffle is returning a suffle deck then this value is passed to deal method as well, but as the first argument
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
