require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          pending "fill this spec in with a meaningful example"
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          pending "fill this spec in with a meaningful example"
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          pending "this is just the same as the example above"
        end
      end
    end
  end

#everything below here is much more difficult; look at docs and convert what the docs say into the spec
  describe :find do
    #THIS IS WRONG: it_should_behave_like "yield to all elements in sorted array", :find

    # write better test
    it "finds the value and returns the value" do
      sorted_array.find  { |i| i == 4 }.should == 4    
    end

    it "cannot find the value and returns nil" do
      sorted_array.find  { |i| i == 10 }.should == nil    
      #pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-find"
    end
  end

  describe :inject do
    #THIS IS WRONG:  it_should_behave_like "yield to all elements in sorted array", :inject
    # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    
    # NOTE:  ED didn't finish copying the below text example 
    #below is optional
    # specify do 
    #      expect do |b| 
    #        block_with_two_args = Proc.new { |acc, el| return true }
    #        sorted_array.send(method, &b) 
    #      end.to yield_successive_args([0,2], [2,3], [5,4], [9,7], [16,9]) 
    #    end
    # end
    it "should accumulate sum of sorted_array to equal 25" do
      sorted_array.inject { |sum, n| sum + n }.should == 25 
      end
    # it " should accumulate product 1..5" do
    #  (1..5).inject { |product, n| product * n }.should == 120 
    # end
  end
end