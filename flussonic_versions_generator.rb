# frozen_string_literal: true

def generate_versions_arr(current_date)
  formated_cd = "#{current_date.year % 100}.#{format('%02d', current_date.month)}"
  make_last_vers([formated_cd])
end

def make_last_vers(last_flussonic_vers)
  year, month = last_flussonic_vers.last.split('.').map(&:to_i)
  9.times do
    # он ругается на 11>10 строчек, но когда я сворачиваю if в тернарник, vsкодовский rubocop его разворачивает назад
    # month == 1 ? (year -= 1, month = 12) : month -= 1
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
