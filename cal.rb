# Calculator 

@prompt = '>'


def operation_select (num1, num2)
  operation = ''
  puts "Which operation would you like to use? 1.add; 2.sub; 3.multiply; 4.divide"
  print @prompt
  operation = gets.chomp
  
  if operation == '1'
     result = num1.to_i + num2.to_i
  elsif operation == '2'
     result = num1.to_i - num2.to_i
  elsif operation == '3'
     result = num1.to_i * num2.to_i
  elsif operation == '4'
     result = num1.to_f / num2.to_f
  else 
     puts "Please enter 1, 2, 3 or 4."    
     operation_select(num1, num2)
     return                             # this return is rather important. otherwise, it will puts more than twice.
  end 
  
  puts "Result is: #{result}."

end

puts
puts "Calculator stands by."

puts "What's the first number?"
print @prompt
x1 = gets.chomp

puts "What's the second number?"
print @prompt
x2 = gets.chomp

operation_select(x1, x2)
	