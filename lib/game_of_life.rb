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
    def initialize(board)
      @cells = []
      board.split(/\n/).each { |line| @cells << line.split(//)}
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
  end
end
