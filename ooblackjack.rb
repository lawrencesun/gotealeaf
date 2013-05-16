# ==Blackjack Game==

# Object Oriented Version
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
  
  def initialize

  end
end

class Deck
  def initialize

  end
end

class Player
  def initialize

  end
end

class Dealer
  def initialize

  end
end

class Hand
  def initialize

  end
end



# calculate the total value of cards in hands
def sums_up(cards)   
	sum = 0
  new_arr = cards.map{|e| e[0]}  # generate a new array contain the values returned by the block

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


# Shuffle the cards
def shuffle_cards 

  
  suits = ["Spades", "Hearts", "Diamonds", "Clubs"] 
  cards = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King) # a better way to creat an array of strings

  deck = cards.product(suits) # returns an array of all combinations of elements from all arrays
  deck.shuffle! # shuffles elements in self in place

end


# show cards
def show_cards(player_cards, dealer_cards, player_total, dealer_total)

  print "You have "
  player_cards.each do |cards|
    print "#{cards.join(" of ") + ", "} "
  end
  
  print "and your total value is #{player_total}."
  puts

  print "Dealer has "
  dealer_cards.each {|cards| print "#{cards.join(" of ") + ", "}" }
    
  print "and dealer's total value is #{dealer_total}."
  puts

end

def check_cards(cards_total, turn)

  if cards_total == 21
    puts "\nCongratulations! You win!" if turn == 'player'
    puts "\nDealer hits blackjack, you lose." if turn == 'dealer'
    exit   # ends the program
  elsif cards_total > 21
    puts "\nOh no! Busted! You lose..." if turn == 'player'
    puts "\nDealer busted! You win!" if turn == 'dealer'
    exit
  else 
    return 
  end
  
end

def compare_cards(player_total, dealer_total)
  puts
  puts "Compare cards...\n"
  
  if player_total > dealer_total
    puts
    puts "Congratulations! You win!"
    exit
  elsif player_cards < dealer_total
    puts
    puts "Sorry, you lose."
    exit
  else
    puts "\nYou and the dealer has the same total value. Tie."
    exit
  end
end


# Welcome 

puts 
puts "Hi, Welcome to Blackjack!"
puts "What's your name?"
name = gets.chomp.capitalize
puts
puts "Hi, #{name}! Let's play!\n"

# shuffle cards
deck = shuffle_cards  

# Deal the cards
puts
puts "Now dealing the cards......"
puts 

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

player_total = sums_up(player_cards)
dealer_total = sums_up(dealer_cards)

# Show cards
show_cards(player_cards, dealer_cards, player_total, dealer_total)


# player turn. Hit or stand

check_cards(player_total, 'player')

while player_total < 21
  puts "\nWhat action would you like to take? 1. hit; 2. stay."
  action = gets.chomp

  if !['1', '2'].include?(action)
    puts "You must enter 1 or 2."
    next  # to the next loop
  end  

  if action == '2'
    puts "\nYou choose to stand...\n"
    break  # break the loop
  end

  if action == '1'
    puts "\nYou choose to hit...\n"
    player_cards << deck.pop
    player_total = sums_up(player_cards)
    show_cards(player_cards, dealer_cards, player_total, dealer_total)
    
    check_cards(player_total, 'player')

  end
  
end

# dealer turn

check_cards(dealer_total, 'dealer')

while dealer_total < 17
  dealer_cards << deck.pop
  dealer_total = sums_up(dealer_cards)
  show_cards(player_cards, dealer_cards, player_total, dealer_total)

  check_cards(dealer_total, 'dealer') 

end


# Compare

compare_cards(player_total, dealer_total)
