# ==Blackjack Game==

# Some rules..if you are blackjack rookie like me.. 
# "deck" means "pack"
# a "hand" is the subset of cards held at one time by a player 
# Ace is worth 1 or 11; Jack, Queen and King worth 10; others are worth the numerical value
# player can choose "hit" or "stay", which means deal another card or save the total value and return to dealer
# busted and lost when sum up is greater than 21.
# sum up equals 21, win
# dealer must hit until she has at least 21.
# if dealer busted, player wins; if sums up equals 21, dealer wins
# if dealer stays, compare the sums, higher value wins. 



def sums_up(cards)   # calculate the total value of cards in hands
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

def shuffle_cards 
  # Shuffle the cards
  
  suits = ["Spades", "Hearts", "Diamonds", "Clubs"] 
  cards = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King) # a better way to creat an array of strings

  deck = cards.product(suits) # returns an array of all combinations of elements from all arrays
  deck.shuffle! # shuffles elements in self in place

end

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


if player_total == 21
  puts "Congratulations! You win!"
  exit
end

  

# Hit or stay

puts "\nWhat action would you like to take? 1. hit; 2. stay."
action = gets.chomp

if action == '1'
  puts "\nYou choose to hit...\n"
  player_cards << deck.pop
  player_total = sums_up(player_cards)
  show_cards(player_cards, dealer_cards, player_total, dealer_total)

  if player_total == 21
    puts "Congratulations! You win!"
    exit

  elsif player_total > 21
    puts "Busted... the dealer wins."
    exit
  end
end



=begin
  
rescue Exception => e
  
end

# Compare

if player_total > dealer_total
  puts "Your get #{player_total}, and the dealer gets #{dealer_total}."
  puts "Congratulations! You win!"
  exit
elsif player_cards < dealer_total
  puts "The dealer gets #{dealer_total} while you get #{player_total}."
  puts "Sorry, you lose."
  exit
else
  puts "You and the dealer has the same total value #{player_total}. Tie."
end

=end