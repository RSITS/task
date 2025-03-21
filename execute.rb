# frozen_string_literal: true

require_relative 'interface'

puts 'Available licenses finder'

loop do
  Interface.interface
  print 'Repeat? [y/n]: '
  break unless gets.strip.eql?('y')
end
