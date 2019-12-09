class Admin

	def self.log_scores(duration)
		system('clear')

		open('high_scores.txt', 'a') do |file|
			file.puts duration
		end

		system('say congratulations')
		puts "A player has won the game"
		puts "Here are the high scores:"

		scores = self.get_scores
		counter = 0

		pretty_file_data = scores.map do |entry|
			counter += 1
			"#{counter}. #{entry.to_s}ms"
		end

		puts pretty_file_data
	end

	private

	def self.get_scores
		file = File.open('high_scores.txt')
		file_data = file.readlines.map(&:chomp).map(&:to_i).sort
	end
end