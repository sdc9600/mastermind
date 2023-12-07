# Methods relating to the game of Mastermind
require 'pry-byebug'
class MastermindHumanBreaker
  attr_reader :turn
  def initialize
    @computer_code = Array.new(4)
    @colours = ['B','G','R','Y','O','V']
    @guess = ''
    @turn = 1
  end

  def generate_computer_code
    @computer_code.each_index {|i|  @computer_code[i] = @colours.sample}
  end

  def human_guess_code
    puts "Please enter a four character string containing a combination of 'b, g, r, y, o, v to guess the secret code!"
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
    puts "\nYour guess contains #{correct_position} colours in the right posiiton, 
    #{incorrect_position} colours in the incorrect position
    and #{incorrect_peg} colours not existing in the code!\n"
    @turn +=1
    @guess = ''
  end
end

class MastermindComputerBreaker
  attr_reader :set_of_guesses
  def initialize
    @human_code = ''
    @turn = 1
    @colours = ['B','G','R','Y','O','V']
    @set_of_guesses = []
  end

  def computer_set
    i = 0
    j = 0
    k = 0
    l = 0
    until @set_of_guesses.length == 1296
    @set_of_guesses.append(@colours[i]+@colours[j]+@colours[k]+@colours[l])
    if l < 5
      l += 1
    elsif k < 5
      k += 1
      l = 0
    elsif j < 5
      j += 1
      k = 0
      l = 0
    elsif i < 5
      i += 1
      j = 0
      k = 0
      l = 0
    end
  end
end

  def human_set_code
    puts "Please enter a four character string containing a combination of 'b, g, r, y, o, v to guess the secret code!"
    until @human_code.length == 4 && @human_code.scan(/[BGRYOV]/).join.length == 4
      @human_code = gets.chomp.upcase
    end
    @human_code = @human_code.chars
  end
end

game = MastermindComputerBreaker.new
game.human_set_code
print game.computer_set
print game.set_of_guesses.length




if 1==0
game = MastermindHumanBreaker.new
game.generate_computer_code


while game.turn < 13
  game.human_guess_code
  game.evaluate_guess
end
end