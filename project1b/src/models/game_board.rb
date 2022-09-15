# $EMPTY = "nil"
# $BOAT = 1
# $ATTACKED = 2

class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column


    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @gameboard = Array.new(max_row){Array.new(max_column){0}}
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column

    # @orientation is one of following `String`s
    #  - "Up" | "Down" | "Left" | "Right"
    def add_ship(ship)
        if ship.start_position.row > @max_row or ship.start_position.row < 1 or ship.start_position.column > @max_column or ship.start_position.column < 1
            false
        elsif ship.orientation == "Up" and ship.start_position.row - (ship.size - 1) >= 1
            for i in 0..ship.size - 1
                if @gameboard[ship.start_position.row - 1 - i][(ship.start_position.column - 1)] != 0
                    false
                end
            end
            for i in 0..ship.size - 1
                @gameboard[ship.start_position.row - 1 - i][(ship.start_position.column - 1)] = 1
            end
            true

        elsif ship.orientation == "Down" and ship.start_position.row + (ship.size - 1) <= @max_row
            for i in 0..ship.size - 1
                if @gameboard[ship.start_position.row - 1 + i][ship.start_position.column - 1] != 0
                    false
                end
            end
            for i in 0..ship.size - 1
                @gameboard[ship.start_position.row - 1 + i][ship.start_position.column - 1] = 1
            end
            true

        elsif ship.orientation == "Right" and ship.start_position.column + (ship.size - 1) <= @max_column
            for i in 0..ship.size - 1
                if @gameboard[ship.start_position.row - 1][ship.start_position.column - 1 + i] != 0
                    false
                end
            end
            for i in 0..ship.size - 1
                @gameboard[ship.start_position.row - 1][ship.start_position.column - 1 + i] = 1
            end
            true

        elsif ship.orientation == "Left" and ship.start_position.column - (ship.size - 1) >= 1
            for i in 0..ship.size - 1
                if @gameboard[ship.start_position.row - 1][ship.start_position.column - 1 - i] != 0
                    false
                end
            end
            for i in 0..ship.size - 1
                @gameboard[ship.start_position.row - 1][ship.start_position.column - 1 - i] = 1
            end
            true

        else
            false
        end
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position
        if position.row > @max_row or position.row < 1 or position.column > @max_column or position.column < 1
            return false
        end
        # update your grid
        if @gameboard[position.row - 1][position.column - 1] == 1 or @gameboard[position.row - 1][position.column - 1] == 2
            @gameboard[position.row - 1][position.column - 1] = 2
            return true
        end
        return false
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        attacked = 0
        for i in 0..@gameboard.length - 1
            for j in 0..@gameboard[i].length - 1
                if @gameboard[i][j] == 2
                    attacked = attacked + 1
                end
            end
        end
        return attacked
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        for i in 0..@gameboard.length - 1
            for j in 0..@gameboard[i].length - 1
                if @gameboard[i][j] == 1
                    return false
                end
            end
        end
        true
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
        for item in @gameboard
            puts item.to_s
        end
    end
end
