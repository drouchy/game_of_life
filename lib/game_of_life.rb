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
      @board = []
      board.split(/\n/).each { |line| @board << line.split(//)}
    end
    
    def to_s
      lines = []
      @board.each {|line| lines << line.join}
      lines.join("\n")
    end
    
    def cell(row, col)
      @board[row, col]
    end
  end
end
