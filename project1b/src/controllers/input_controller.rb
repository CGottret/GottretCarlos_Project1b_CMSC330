require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    gameboard = GameBoard.new 10, 10
    valid_ships = 0

    read_file_lines(path) do |line|
        line =~ /\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/
        if line =~ /\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/ and valid_ships <= 5
            pos = Position.new(line.scan(/\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/).first[0].to_i, line.scan(/\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/).first[1].to_i)
            ship = Ship.new(pos, line.scan(/\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/).first[2].to_s, line.scan(/\(([0-9]+),([0-9]+)\), ([A-Za-z]+), ([1-5])/).first[3].to_i)
            gameboard.add_ship(ship)  
            valid_ships = valid_ships + 1
        end
    end

    if valid_ships == 5
        return gameboard
    else
        return nil
    end
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    attacks = []
    read_file_lines(path) do |line|
        if line =~ /\(([0-9]+),([0-9]+)\)/
            pos = Position.new(line.scan(/\(([0-9]+),([0-9]+)\)/).first[0].to_i, line.scan(/\(([0-9]+),([0-9]+)\)/).first[1].to_i)
            attacks.push(pos)
        end
    end
    return attacks
end


# ===========================================
# ======DON'T modify the following code======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end
