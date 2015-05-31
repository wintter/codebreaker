require_relative 'version'
require_relative 'score'

module Codebreaker
  class Game
    attr_reader :code, :attempt, :hint

    def initialize
      @code = 4.times.map { rand(1..6) }.join
      @attempt = 5
      @hint = true
    end

    def get_hint
      return '' unless @hint
      @hint = false
      result = '****'
      val = rand(4)
      result[val] = @code[val]
      result
    end

    def comparison user_code
      return 'Incorrect_code' unless user_code.match(/^[1-6]{4}/)
      return 'Game over' if @attempt == 0
      @attempt -= 1
      message = String.new
      code_copy = @code.clone
      user_code_copy = user_code.clone
      (0...4).each do |val|
        if @code[val]==user_code[val]
          message << '+'
          code_copy.slice! @code[val]
          user_code_copy.slice! @code[val]
        end
      end

      user_code_copy.each_char do |val|
        if code_copy.include? val
          code_copy.slice! code_copy[code_copy.index val]
          message << '-'
        end
      end

      message
    end

  end
end
