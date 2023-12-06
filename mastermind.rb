# Methods relating to the game of Mastermind
require 'pry-byebug'
class Mastermind
  def initialize
    @computer_code = Array.new(4)
    @colours = ['B','G','R','Y','O','V']
    @guess = ''
  end

  def generate_computer_code
    @computer_code.each_index {|i|  @computer_code[i] = @colours.sample}
  end

  def human_guess_code
    puts "Please enter a four character string containing a combination of 'b, g, r, y, o, v to guess 
    the secret code!"
    until @guess.length == 4 && @guess.scan(/[BGRYOV]/).join.length == 4
      @guess = gets.chomp.upcase
      #binding.pry
    end
    @guess = @guess.chars
  end
  def evaluate_guess
    incorrect_peg = 0
    correct_position = 0
    incorrect_position = 0
    @guess.each_index do 
      |i|
      if
      @guess[i] == @computer_code[i]
        correct_position += 1
      elsif
        @computer_code.include? @guess[i]
          incorrect_position +=1
      else
        incorrect_peg += 1
      end
    end
    puts "Your guess contains #{correct_position} colours in the right posiiton, 
    #{incorrect_position} colours in the incorrect position
    and #{incorrect_peg} colours not existing in the code!"
  end
end

game = Mastermind.new

game.human_guess_code
game.evaluate_guess