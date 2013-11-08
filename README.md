gravytrain
==========

Readabilify your Ruby method calls

## Usage

```ruby
class Fibonacci
  include Gravytrain::Goodness

  def first_fibonacci_numbers(n, starting_with=[0,1])
    # implementation to get the first +n+ fib numbers
  end
end

Fibonacci.new.first_(5).fibonacci_numbers
# => [0, 1, 2, 3, 5]

```
