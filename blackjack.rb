# ==Blackjack Game==

# "deck" means "pack"
# a "hand" is the subset of cards held at one time by a player 
# Ace is worth 1 or 11; Jack, Queen and King worth 10; others are worth the numerical value
# player can choose "hit" or "stay", which means deal another card or save the total value and return to dealer
# busted and lost when sum up is greater than 21.
# sum up equals 21, win
# dealer must hit until she has at least 21.
# if dealer busted, player wins; if sums up equals 21, dealer wins
# if dealer stays, compare the sums, higher value wins. 

suits = ["spades", "hearts", "diamonds", "clubs"] 
cards = %w(Ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King) # a better way to creat an array of strings


def sums_up(cards)
	sum = 0
  cards.each do |x|
  	if x == 'Ace'
  		sum += 11
    elsif x.to_i == 0
    	# instead of "x == 'Jack' || x == 'Queen' || x == 'King'""
    	sum += 10
    else 
    	sum += x.to_i
    end
	sum
end





puts 
puts "Hi, Welcome to Blackjack!"
puts "What's your name?"
name = gets.chomp
puts
puts "Hi, #{name}! Let's play!"