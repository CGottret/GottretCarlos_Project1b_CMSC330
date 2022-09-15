require_relative "../../src/controllers/input_controller.rb"
require_relative "../../src/controllers/game_controller.rb"
require_relative "../../src/models/game_board.rb"
require_relative "../../src/models/position.rb"
require_relative "../../src/models/ship.rb"

p1_ships = []
p1_perf_atk = []
p2_ships = []
p2_perf_atk = []
for i, size in [1,2,3,4].zip([4,5,3,2])
    pos0 = Position.new(i, i)
    pos1 = Position.new(i + 4, i + 4)
    p1_ships << Ship.new(pos0, "Right", size)
    p2_ships << Ship.new(pos1, "Right", size)
    for j in 0..(size - 1)
        p2_perf_atk << Position.new(i, i + j)
        p1_perf_atk << Position.new(i + 4, i + j + 4)
    end
end

puts "p1 ships"
for item in p1_ships
    puts item.to_s
end

# puts "p2 ships"
# for item in p2_ships
#     puts item.to_s
# end

# puts "p1 att"
# for item in p1_perf_atk
#     puts item.to_s
# end

# puts "p2 att"
# for item in p2_perf_atk
#     puts item.to_s
# end

test_board = GameBoard.new 10, 10

test_board.add_ship(p1_ships[0])
for shp in p1_ships[1..] 
    test_board.add_ship(shp)
end

for i in p2_perf_atk
    puts test_board.attack_pos(i) == true
end
test_board.to_s

# # Property: Nothing will change for a miss
# refute(test_board.attack_pos(Position.new(2, 1)), "Attack should have missed but hit")