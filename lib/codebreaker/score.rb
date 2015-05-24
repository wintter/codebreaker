module Codebreaker
  class Score

    SCORE_INFO = 'score.txt'

    class << self

      def get_info player = {}
        "Player: #{player[:name]} , attempts: #{player[:user_attempts]}"
      end

      def load
        r_data = String.new
        File.readlines(SCORE_INFO).each do |line|
          r_data << line
        end
        r_data
      end

      def set data
        return false unless File.exist? SCORE_INFO
        r_data = load
        File.open SCORE_INFO, 'w' do |f|
          f.puts r_data << data
        end
      end

      def save_result number_attempts
        puts 'Would you like save your score? Press your name if yes'
        user_name = gets
        if user_name
          info = self.get_info name: user_name.chomp!, user_attempts: number_attempts
          self.set info
        end
      end

    end
  end
end
