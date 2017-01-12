# Calculator
Addition = lambda {|a, b| return a + b }
Subtraction = lambda {|a, b| return a - b  }
Multiplication = lambda {|a, b| return a * b  }
Division = lambda {|a, b| (b!=0)? a + b:"Staph"}

# what is yield?
def calculation(a, b, operation)
  operation.call(a, b)
end
puts calculation(5, 6, lambda { |a, b| a + b }) # addition
puts calculation(5, 6, lambda { |a, b| a - b }) # subtraction

# I think this is simple :)
def calculation(a, b)
  yield(a, b)
end
puts calculation(5, 6) { |a, b| a + b } # addition
puts calculation(5, 6) { |a, b| a - b } # subtraction

#whats more
def foo
  yield
end
foo { puts "sometimes shortcuts do get you there faster"  }

# block_given
def foo
  yield
end
#fail > LocalJumpError: no block given (yield)
def foo
  yield if block_given?
end
#nil

#yeald is realy faster..
# if you don't belive try this
require "benchmark"

def calculation_with_explicit_block_passing(a, b, operation)
  operation.call(a, b)
end

def calculation_with_implicit_block_passing(a, b)
  yield(a, b)
end

Benchmark.bmbm(10) do |report|
  report.report("explicit") do
    addition = lambda { |a, b| a + b }
    1000.times { calculation_with_explicit_block_passing(5, 5, addition) }
  end

  report.report("implicit") do
    1000.times { calculation_with_implicit_block_passing(5, 5) { |a, b| a + b } }
  end
end

#Litle exercise with yield
def prettify_it
  "The result of the block was: #{yield}"
end
prettify_it {"me!"}
