# frozen_string_literal: true

def calc_answer(entries, n)
  entries.combination(n).each { |e| return e.reduce(:*) if e.sum == 2020 }
end

entries = File.readlines('../inputs/advent1.txt').map(&:to_i)

puts "part 1 answer is #{calc_answer(entries, 2)}"
puts "part 2 answer is #{calc_answer(entries, 3)}"
