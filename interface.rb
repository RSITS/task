# frozen_string_literal: true

require 'date'
require_relative 'functional'

def interface
  puts "Start\n"

  license = make_license

  puts "license info\n"
  puts license
end

interface
