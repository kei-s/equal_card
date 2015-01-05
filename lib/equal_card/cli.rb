require 'thor'
require 'equal_card/cards'

class EqualCard::CLI < Thor
  desc 'answer CARDS', 'カードを並べ替えて答えを表示する'
  def answer(cards)
    equal = EqualCard::Cards.new(cards)
    puts "カードは #{cards}"
    equal.answers.each do |answer|
      puts answer
    end
  end
end
