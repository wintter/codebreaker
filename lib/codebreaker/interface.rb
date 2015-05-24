require_relative 'version'
require_relative 'game'
require_relative 'score'

module Codebreaker

  class GameInterface

    def initialize
      @game = Game.new
    end

    def run
      puts "Hello, lets try to guess secret code\nEnter 'hint' for display hint"
      (1..@game.attempt).each do |val|
        choose = gets.chomp!
        if choose == 'hint' && @game.hint
          puts @game.get_hint
        else
          result = @game.comparison choose
          if result == '++++' || val == @game.attempt
            puts 'You won!' if result == '++++'
            Score.save_result val
            puts 'Would you like start a new game?'
            user_choice = gets
            user_choice.chomp! == 'y' ? GameInterface.new.run : exit
          end
          puts result
        end
      end
    end

  end

end


