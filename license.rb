# frozen_string_literal: true

# this class contain info about license
class License
  def initialize(paid_till, max_version, min_version)
    @paid_till = paid_till
    @max_version = max_version
    @min_version = min_version
  end

  attr_accessor :paid_till, :max_version, :min_version

  #  def to_s
  #    "license info:\n" \
  #    "paid till: #{@paid_till}\n" \
  #    "max_vers: #{@max_version}\n" \
  #    "min_vers: #{@min_version}\n"
  #  end
end
