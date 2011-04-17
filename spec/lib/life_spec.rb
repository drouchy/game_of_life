require 'spec_helper'
require 'game_of_life'

describe GameOfLife::Life do
  
  before(:all) do
    @basic_board = "  x \n"
  end
  
  before(:each) do
    @life = GameOfLife::Life.new(@basic_board)
  end
  
  it 'should respond to cell' do    
    @life.should respond_to(:cell)
  end
  
  
  it 'should be able to access cells' do
    @life.cell(0,0).should == ' '
    @life.cell(0,2).should == 'x'
  end
end