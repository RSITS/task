# frozen_string_literal: true

def generate_versions_arr(current_date, num)
  formated_cd = "#{current_date.year % 100}.#{format('%02d', current_date.month)}"
  last_flussonic_vers = [formated_cd]
  year, month = last_flussonic_vers.last.split('.').map(&:to_i)
  make_last_vers(last_flussonic_vers, num, year, month)
end

def make_last_vers(last_flussonic_vers, num, year, month)
  (num - 1).times do
    if month == 1
      year -= 1
      month = 12
    else
      month -= 1
    end
    last_flussonic_vers.unshift("#{year}.#{format('%02d', month)}")
  end
  last_flussonic_vers
end
