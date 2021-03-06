require 'spec_helper'
require 'game_of_life'

describe GameOfLife::Game do
  before(:all) do
    # testing data:
    # http://fr.wikipedia.org/wiki/Fichier:Gospers_glider_gun.gif
    # http://commons.wikimedia.org/wiki/File:Game_of_life_glider_gun.png
    @starting_board    = "                        x           \n"
    @starting_board   += "                      x x           \n"
    @starting_board   += "            xx      xx            xx\n"
    @starting_board   += "           x   x    xx            xx\n"
    @starting_board   += "xx        x     x   xx              \n"
    @starting_board   += "xx        x   x xx    x x           \n"
    @starting_board   += "          x     x       x           \n"
    @starting_board   += "           x   x                    \n"
    @starting_board   += "            xx                      \n"
    @starting_board   += "                                    \n" * 27

    @after_one_board   = "                       x            \n"
    @after_one_board  += "                     x x            \n"
    @after_one_board  += "            x       x x           xx\n"
    @after_one_board  += "           xx      x  x           xx\n"
    @after_one_board  += "xx        xx    xx  x x             \n"
    @after_one_board  += "xx       xxx    xx   x x            \n"
    @after_one_board  += "          xx    xx     x            \n"
    @after_one_board  += "           xx                       \n"
    @after_one_board  += "            x                       \n"
    @after_one_board  += "                                    \n" * 27

    @after_five_board  = "                      xx            \n"
    @after_five_board += "                        x           \n"
    @after_five_board += "           xx            x        xx\n"
    @after_five_board += "           xx    x       x        xx\n"
    @after_five_board += "xx      xx     xx        x          \n"
    @after_five_board += "xx     xxx     x  xx    x           \n"
    @after_five_board += "        xx      xxxxx xx            \n"
    @after_five_board += "           xx    x                  \n"
    @after_five_board += "           xx                       \n"
    @after_five_board += "                                    \n" * 27
  end

  before(:each) do
    @game = GameOfLife::Game.new(@starting_board)
  end

  it 'should be initialized without arguments' do
    lambda { GameOfLife::Game.new }.should_not raise_error
  end

  it 'should be initialized with arguments' do
    lambda { GameOfLife::Game.new(@starting_board) }.should_not raise_error
  end

  it 'should respond to board' do
    @game.should respond_to(:board)
  end

  it '#board should return starting board after initializazion' do
    @game = GameOfLife::Game.new(@starting_board)
    @game.board.should == @starting_board
  end

  it 'should respond to run' do
    @game.should respond_to(:run)
  end

  it '#run should accept no argument' do
    lambda { @game.run }.should_not raise_error
  end

  it '#run should accept a numeric argument' do
    lambda { @game.run(5) }.should_not raise_error
  end

  it 'should run game for one round' do
    @game.run
    @game.board.should == @after_one_board
  end


  it 'should run game for five round' do
    @game.run(5)
    @game.board.should == @after_five_board
  end

  it 'should print board' do
    @game.board.to_s.should == @starting_board
  end
end

describe GameOfLife::Life do
  
  before(:all) do
    @basic_board  = "  x \n"*2
  end
  
  before(:each) do
    @life = GameOfLife::Life.new(@basic_board)
  end
  
  it 'should respond to cell' do    
    @life.should respond_to(:cell)
  end
  
  
  it 'should be able to access cells' do
    @life.cell(0,0).should == ' '
    @life.cell(1,2).should == 'x'
  end
  
  describe '#count living neighbours' do
    it 'a one cell board should not have any living neighbours' do
      @life = GameOfLife::Life.new('x')
      
      @life.count_living_neighbours(0,0).should == 0
    end
    
    it 'should count living neighbours on the same line' do
      @life = GameOfLife::Life.new('xxx')
      
      @life.count_living_neighbours(0,1).should == 2
    end
    
    it 'should count living neighbours on the previous and next line' do
      @life = GameOfLife::Life.new("xxx\n"*3)
      
      @life.count_living_neighbours(1,1).should == 8
    end
  end
  
  describe '#tic' do
    it 'should respond to tic' do
      @life.should respond_to(:tic)
    end
    
    it 'Any live cell with fewer than two live neighbours dies, as if caused by under-population' do
      @life = GameOfLife::Life.new(" x ")
      
      @life.tic
      
      @life.cells.should == [[' ', ' ', ' ']]
    end
    
    it 'Any live cell with two or three live neighbours lives on to the next generation.' do
      @life = GameOfLife::Life.new("x  \n x \n  x")
      
      @life.tic
      
      @life.cells.should == [[' ', ' ', ' '], [' ', 'x', ' '],[' ', ' ', ' ']]
    end
    
    it 'Any live cell with more than three live neighbours dies, as if by overcrowding.' do
      @life = GameOfLife::Life.new("x  \nxxx\n  x")
      
      @life.tic
      
      @life.cells.should == [['x', ' ', ' '], ['x', ' ', 'x'], [' ', ' ', 'x']]
    end
    
    it 'Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
      @life = GameOfLife::Life.new("x \nxx\n")
      
      @life.tic
      
      @life.cells.should == [['x', 'x'], ['x', 'x']]
    end
  end
end
