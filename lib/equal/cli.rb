require File.expand_path('../../equal', __FILE__)

class Equal::CLI < Thor
  desc 'answer CARDS', 'カードを並べ替えて答えを表示する'
  def answer(cards)
    equal = Equal::Cards.new(cards)
    puts "カードは #{cards}"
    equal.answers.each do |answer|
      puts answer
    end
  end
end
