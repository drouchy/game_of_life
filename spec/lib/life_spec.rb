require 'spec_helper'
require 'game_of_life'

describe GameOfLife::Life do
  
  it 'should respond to cell' do
    board = "  x \n"
    life = GameOfLife::Life.new(board)
    
    life.should respond_to(:cell)
  end
  
  
  it 'should be able to access cells' do
    board = "  x \n"
    
    life = GameOfLife::Life.new(board)
    
    life.cell(0,0).should == ' '
    life.cell(0,2).should == 'x'
  end
end