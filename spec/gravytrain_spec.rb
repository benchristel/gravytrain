require_relative '../lib/gravytrain.rb'

describe 'a method on a class including Gravytrain::Goodness' do
  let(:qlass) do
    Class.new do
      include ::Gravytrain::Goodness
      
      def first_fibonacci_numbers(n, beginning_with=[0,1])
        n -= beginning_with.length
        fib = beginning_with.dup
        n.times do
          n3xt = (fib[-2] + fib[-1])
          fib << n3xt
          yield n3xt, fib if block_given?
        end
        fib
      end
    end
  end
  
  let(:fib) { qlass.new }
  
  it 'can be called with interpolated arguments' do
    fib.first_(5).fibonacci_numbers.should == [0, 1, 1, 2, 3]
  end
  
  it 'can take a block parameter' do
    yielded = []
    fib.first_(5).fibonacci_numbers { |f| yielded << f }
    yielded.should == [1, 2, 3]
  end
  
  it 'can be called normally' do
    fib.first_fibonacci_numbers(5).should == [0, 1, 1, 2, 3]
  end
  
  it 'ignores method fragments beginning in an underscore' do
    fib.first_(5).fibonacci_numbers_._starting_with([1,2]).should == [1, 2, 3, 5, 8]
  end
end
