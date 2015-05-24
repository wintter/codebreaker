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
      @hint = false
      result = '****'
      val = rand(4)
      result[val] = @code[val]
      result
    end

    def comparison user_code
      return 'Incorrect_code' unless user_code.match(/^[1-6]{4}/)
      message = String.new
      index = String.new
      code = @code.clone
      (0...4).each do |val|
        if @code[val]==user_code[val]
          message << '+'
          index << @code[val]
        end
      end

      code.delete! index.split('').to_s
      user_code.delete! index.split('').to_s

      user_code.each_char do |val|
        if code.include? val
          code.slice! code[code.index val]
          message << '-'
        end
      end

      message
    end

  end
end
