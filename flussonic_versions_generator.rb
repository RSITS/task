# frozen_string_literal: true

# this class is for generating last versions
class VersionsGenerator
  def self.generate_versions(current_date, num)
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
    num.zero? ? [] : last_flussonic_vers
  end
end
