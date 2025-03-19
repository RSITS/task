# frozen_string_literal: true

# this class is for generating last versions
class VersionsGenerator
  def self.generate_versions
    current_date = read_current_date
    num = read_num
    last_flussonic_vers = [Version.new(Version.formate_date(current_date))]
    year, month = last_flussonic_vers.last.date.split('.').map(&:to_i)
    make_last_versions(last_flussonic_vers, num, year, month)
  end

  def self.make_last_versions(last_flussonic_vers, num, year, month)
    (num - 1).times do
      if month == 1
        year -= 1
        month = 12
      else
        month -= 1
      end
      last_flussonic_vers.unshift(Version.new("#{year}.#{format('%02d', month)}"))
    end
    last_flussonic_vers
  end

  def self.read_current_date
    puts 'enter current_date yyyy-mm-dd'
    Date.parse(gets.chomp)
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end

  def self.read_num
    puts 'enter limit of last versions(n)'
    num = gets.chomp
    Integer(num)
  rescue ArgumentError => e
    puts "please correct this #{e.message}"
    retry
  end
end
