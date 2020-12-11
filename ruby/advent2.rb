# frozen_string_literal: true

class Row
  def self.parse(file_path, rule_class: Rule)
    File.readlines(file_path).map { |l| new(l, rule_class) }
  end

  attr_reader :raw
  attr_reader :rule
  attr_reader :password

  # @param [String] row
  # @param [Class] rule_class
  def initialize(row, rule_class)
    raise(ArgumentError, "rule_class must be a subclass of 'Rule' but is '#{rule_class}'") unless rule_class <= Rule

    @raw = row.strip
    @rule = rule_class.new(self)
    @password = Password.new(self)
  end

  def valid?
    @password.valid?
  end
end

class Rule
  def initialize(row)
    @row = row
  end

  def valid?(_password)
    false
  end
end

class Part1Rule < Rule
  def initialize(row)
    super
    range_part, @char = @row.raw.split(':').first.split(' ')
    @range = Range.new(*range_part.split('-').map(&:to_i))
  end

  def valid?(password)
    @range.cover?(password.split('').tally[@char])
  end
end

class Part2Rule < Part1Rule
  def valid?(password)
    (password.to_s[@range.begin-1] == @char) ^ (password.to_s[@range.end-1] == @char)
  end
end

class Password < String
  def initialize(row)
    @row = row
    super(@row.raw.split(': ').last)
  end

  def valid?
    @row.rule.valid?(self)
  end
end

input_file = File.absolute_path(File.join('..', 'inputs', 'advent2.txt'), __dir__)
part1 = Row.parse(input_file, rule_class: Part1Rule)
part2 = Row.parse(input_file, rule_class: Part2Rule)
puts part1.count(&:valid?)
puts part2.count(&:valid?)
