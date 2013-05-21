# ==Blackjack Game==

# Object Oriented Version
# Module: Hand  --> show hand's card, calculate the total value.
# Class: Card, Deck, Player, Dealer, Game.
# Card: present format
# Deck: generate the shuffled deck of cards and deal cards.
# Player, Dealer: mixin module Hand
# Game: initialize deck, player, dealer; greeting, deal cards, show cards, hit or busted, player's turn, dealer's turn, compare total value...


# Some rules..if you are blackjack rookie like me.. 
# "deck" means "pack"
# a "hand" is the subset of cards held at one time by a player 
# Ace is worth 1 or 11; Jack, Queen and King worth 10; others are worth the numerical value
# player can choose "hit" or "stand", which means deal another card or save the total value and return to dealer
# busted and lost when sum up is greater than 21.
# sum up equals 21, win
# dealer must hit until she has at least 21.
# if dealer busted, player wins; if sums up equals 21, dealer wins
# if dealer stays, compare the sums, higher value wins. 

class Card 
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit 
    @value = value
  end

  def to_s
    "#{value} of #{suit}"
  end

end

class Deck
  attr_accessor :cards
  
  def initialize
    @cards = []
    suit = ["Spades", "Hearts", "Diamonds", "Clubs"] 
    value = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King) # a better way to creat an array of strings
    suit.each do |suit|
      value.each do |value|   
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end
  
  def deal_cards
    cards.pop
  end
      
end

module Hand
  # calculate the total value of cards in hands
  def sums_up 
    sum = 0
    new_arr = cards.map{|card| card.value}  # generate a new array contain the values returned by the block

    new_arr.each do |x| 
      if x == 'Ace'
        sum += 11
      elsif x.to_i == 0
        # instead of "x == 'Jack' || x == 'Queen' || x == 'King'""
        sum += 10
      else 
        sum += x.to_i
      end
    end

    # correct for Aces
    new_arr.select{|e| e == "Ace"}.count.times do # count how many "ace"s and do n times
      sum -= 10 if sum >21
    end

    sum
  end

  # show cards
  def show_cards

    puts "#{name}'s Hand"
    cards.each do |cards|
      print "#{cards}, "
    end
    
    puts "total value is #{sums_up}."
    puts

  end

  def add_cards(new_cards)

    cards << new_cards

  end
  
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

end


class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

end


class Game
  attr_accessor :deck, :player, :dealer

  def initialize 
    @deck = Deck.new
    @player = Player.new("player")
    @dealer = Dealer.new
  end

  def greeting
    puts 
    puts "Hi, Welcome to Blackjack!"
    puts "What's your name?"
    player.name = gets.chomp.capitalize
    puts
    puts "Hi, #{player.name}! Let's play!"
    puts
  end

  def deal
    player.add_cards(deck.deal_cards)
    dealer.add_cards(deck.deal_cards)
    player.add_cards(deck.deal_cards)
    dealer.add_cards(deck.deal_cards)
  end

  def show
    player.show_cards
    dealer.show_cards
  end

  def hit_or_bust(turn)
    case turn
    when "player"
      if player.sums_up == 21
        puts "\nCongratulations! You win!"
        play_again
      elsif player.sums_up > 21
        puts "\nOh no! Busted! You lose..."
        play_again
      end
    when "dealer"
      if dealer.sums_up == 21
        puts "\nDealer hits blackjack, you lose."
        play_again
      elsif dealer.sums_up > 21
        puts "\nDealer busted! You win!"
        play_again
      end
    end
  end

  def player_turn
    puts 
    puts "Your turn."

    hit_or_bust("player")

    while player.sums_up < 21
      puts "\nWhat action would you like to take? 1. hit; 2. stay."
      action = gets.chomp

      if !['1', '2'].include?(action)
        puts "You must enter 1 or 2."
        next  # to the next loop
      end  

      if action == '2'
        puts "\nYou choose to stay..."
        puts
        break  # break the loop
      end

      if action == '1'
        puts "\nYou choose to hit..."
        puts
        player.add_cards(deck.deal_cards)
        player.show_cards
        hit_or_bust("player")
      end
    
    end

  end


  def dealer_turn
    puts
    puts "Dealer's turn.\n"
    
    hit_or_bust("dealer")

    while dealer.sums_up < 17
      dealer.add_cards(deck.deal_cards)
      dealer.show_cards
      hit_or_bust("dealer")
    end

  end


  def compare_cards
    puts 
    puts "Compare cards...\n"
    if player.sums_up > dealer.sums_up
      puts
      puts "Congratulations! You win!"
    elsif player.sums_up < dealer.sums_up
      puts
      puts "Sorry, you lose."
    else
      puts "\nYou and the dealer has the same total value. Tie."
    end
    play_again
  end

  def play_again
    puts "\nWould you like to play blackjack again? Yes or No?\n"
    choice = gets.chomp.capitalize

    if choice == "Yes"
      puts "\n==Starting a new game.==\n"
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start_game
    elsif choice == "No"
      puts "Goodbye."
      exit
    else
      puts "\nPlease enter 'Yes' or 'No'."
      play_again
    end
  end

  def start_game
    greeting
    deal
    show
    player_turn
    dealer_turn
    compare_cards
  end

end

game = Game.new
game.start_game



