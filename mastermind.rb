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
  attr_reader :set_of_guesses, :turn, :black_pegs
  def initialize
    @human_code = ''
    @turn = 1
    @colours = ['B','G','R','Y','O','V']
    @set_of_guesses = []
    @computer_guess = ['B','B','G','G']
    @black_pegs = 0
    @white_pegs = 0
  end

  def computer_set
    i = 0
    j = 0
    k = 0
    l = 0
    until @set_of_guesses.length == 1296
      append_value = (@colours[i]+@colours[j]+@colours[k]+@colours[l]).chars
    @set_of_guesses.append(append_value)
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
    puts "Please enter a four character string containing a combination of 'b, g, r, y, o, v to set the secret code!"
    until @human_code.length == 4 && @human_code.scan(/[BGRYOV]/).join.length == 4
      @human_code = gets.chomp.upcase
    end
    @human_code = @human_code.chars
  end

  def computer_codebreaker
    if @turn == 1
      self.evaluate_computer_guess(@computer_guess)
    end
    @computer_guess = @set_of_guesses.sample
    evaluate_computer_guess(@computer_guess)
  end

  def pop_from_set
    @set_of_guesses.each_index do
      |i|
    direct_hit = 0
    indirect_hit = 0
      @computer_guess.each_index do
        |index|
        if @computer_guess[index] == @set_of_guesses[i][index]
          direct_hit += 1
        elsif @computer_guess[index].include? @set_of_guesses[i].join
        indirect_hit += 1
      end
    end
      
      if @black_pegs == 0 && @white_pegs == 0 && direct_hit != 0
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 1 && @white_pegs == 0 && direct_hit != 1
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 2 && @white_pegs == 0 && direct_hit != 2
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 3 && direct_hit != 3
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 0 && @white_pegs == 1 && indirect_hit != 1
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 0 && @white_pegs == 2 && indirect_hit != 2
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 0 && @white_pegs == 3 && indirect_hit != 3
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 0 && @white_pegs == 4 && indirect_hit != 4
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 1 && @white_pegs == 1 && (direct_hit + indirect_hit) != 2
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 1 && @white_pegs == 2 && (direct_hit + indirect_hit) != 3
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 1 && @white_pegs == 3 && (direct_hit + indirect_hit) != 4
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      elsif @black_pegs == 2 && @white_pegs == 2 && (direct_hit + indirect_hit) != 4
        @set_of_guesses.delete(@set_of_guesses[i])
        i -= 1
      end 
    end
    puts @set_of_guesses.length
  end

  def evaluate_computer_guess(guess)
  incorrect_pegs = 0
  @black_pegs = 0
  @white_pegs = 0
  guess.each_index do 
    |i|
    if   
    guess[i] == @human_code[i]
      @black_pegs += 1
    elsif
      guess.include? @human_code[i]
        @white_pegs +=1
    else
      incorrect_pegs += 1
    end
  end
  puts "\nYour guess contains #{@black_pegs} colours in the right posiiton, 
  #{@white_pegs} colours in the incorrect position
  and #{incorrect_pegs} colours not existing in the code!\n"
  @turn +=1
  end
end

game = MastermindComputerBreaker.new
game.computer_set
game.human_set_code

while game.turn < 20
game.computer_codebreaker
puts game.black_pegs
if game.black_pegs == 4
  puts "You've guessed the code correctly and win!"
  break 
end
game.pop_from_set

end





#game = MastermindHumanBreaker.new
#game.generate_computer_code


#while game.turn < 13
 # game.human_guess_code
 # game.evaluate_guess
#end
