#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
    attr_accessor :board
    
    def initialize(board = '')
      @board = Life.new(board)
    end
    
    def run(rounds = 1)
      
    end
    
    def board
      @board.to_s
    end
  end
  
  class Life
    attr_accessor :cells
    
    LIVING_CELL = 'x'
    DEAD_CELL   = ' '
    
    UNDER_POPULATION = 0..1
    GOOD_POPULATION = 2..3
    NEW_GENERATION = 3
    
    def initialize(board)
      @cells = []
      board.split(/\n/).each { |line| @cells << line.split(//)}
    end
    
    def tic
      @cells = compute_next_life
    end
    
    def to_s
      lines = []
      @cells.each {|line| lines << line.join}
      lines.join("\n") + "\n"
    end
    
    def cell(row, col)
      @cells[row][col] if are_row_and_col_acceptable?(row, col)
    end
    
    def count_living_neighbours(row, col)
      living_neighbours = get_neighbours_of_cell_at(row, col).keep_if {|cell | cell =~ /x/}
      living_neighbours.count
    end
    
    private
    
    def are_row_and_col_acceptable?(row, col)
      is_row_acceptable?(row) && is_col_acceptable_in_row?(row, col)
    end
    def is_row_acceptable?(row)
      row >= 0 && row < @cells.length
    end
    
    def is_col_acceptable_in_row?(row, col)
      col >= 0 && col < @cells[row].length
    end
    
    def get_neighbours_of_cell_at(row, col)
      neighbours = []
      neighbours << cell(row-1, col-1)
      neighbours << cell(row-1, col)
      neighbours << cell(row-1, col+1)
      
      neighbours << cell(row, col-1)
      neighbours << cell(row, col+1)
      
      neighbours << cell(row+1, col-1)
      neighbours << cell(row+1, col)
      neighbours << cell(row+1, col+1)
      
      neighbours
    end
    
    def compute_next_life
      # We suppose a life is a square
      next_life = Array.new(@cells.length)
      @cells.each_with_index do |line, row|
        next_life[row] = Array.new(line.length, DEAD_CELL)
        line.each_with_index do |cell, col|
          
          if is_living_cell?(cell)
            next_life[row][col] = compute_state_for_living_cell(row, col)
          else
            next_life[row][col] = compute_state_for_dead_cell(row, col)
          end
        end
      end
      
      next_life
    end
    
    def compute_state_for_dead_cell(row, col)
      case count_living_neighbours(row, col)
        when NEW_GENERATION
          LIVING_CELL
        else
          DEAD_CELL
        end
    end
    
    def compute_state_for_living_cell(row, col)
      case count_living_neighbours(row, col)
        when UNDER_POPULATION
          DEAD_CELL
        when GOOD_POPULATION
          LIVING_CELL
        else
          DEAD_CELL
        end
    end
    
    def is_living_cell?(cell)
      cell == LIVING_CELL
    end
  end
end
