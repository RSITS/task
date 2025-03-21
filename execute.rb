# frozen_string_literal: true

require_relative 'interface'

puts 'Available licenses finder'

loop do
  Interface.interface
  print 'Press y to repeat: '
  break unless gets.strip.eql?('y')
end
