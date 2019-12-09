require 'ruby2d'

require './admin.rb'
require './config.rb'
require './logger.rb'

set Config::WINDOW_CONFIG

message = Text.new('Welcome to ClickIron', x: 200, y: 20)
game_started = false
start_time = nil
duration = nil
squares = []
num_squares = rand(11) + 1
squares_clicked = 0

on :mouse_down do |event|
	if game_started
		squares.each do |square|
			if square.contains?(event.x, event.y)
				squares = squares.select {|current_square|  current_square != square}
				square.remove
				squares_clicked += 1
			end
			if squares_clicked == num_squares
				duration = ((Time.now - start_time) * 1000).round
				message = Text.new("Neat! Score: #{duration} milliseconds", x: 20, y: 20)
				Admin.log_scores(duration)
				squares_clicked = 0
				game_started = false
			end
		end
		Logger.log_debug_info(squares_clicked, num_squares)
	else
		message.remove
		num_squares.times do
			squares << Square.new(
				x: rand(get(:width) - 25), y: rand(get(:height) - 25),
				size: 25,
				color: 'random'
			)
		end
		game_started = true
		start_time = Time.now
	end
end

show