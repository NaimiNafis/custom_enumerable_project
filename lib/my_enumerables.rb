module Enumerable
  # Your code goes here
  #
  # Because this method is called on Array obj, that's why we
  # can use the methods in Class Array
  def my_select
    arr = []
    my_each do |elem|
      arr.push(elem) if yield(elem)
    end
    arr
  end

  def my_all?
    my_each do |elem|
     unless yield(elem)
       return false
     end
    end
    true
  end

  def my_any?
    my_each do |elem|
      if block_given?
        return true if yield(elem)
      else
        return true if elem
     end
    end
    false
  end

  def my_none?
    my_each do |elem|
      if block_given?
        return false if yield(elem)
      else
        return false if elem
      end
    end
    true
  end

  def my_count
    count = 0
    if block_given?
      my_each do |elem|
        count += 1 if yield(elem)
      end
    else
      return self.length
    end
    count
  end

  def my_map
    # so that we can use like enum = [1, 2, 3].my_map if no block given
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each do |elem|
      arr.push(yield(elem))
    end
    arr
  end

  def my_inject(initial = nil)
    accumulator = initial
    start_index = 0

    if initial.nil?
      accumulator = self[0]
      start_index = 1
    end

    my_each_with_index do |elem, i|
      accumulator = yield(accumulator, self[i])
      #give 2 values to block
      #block decides how to combine those two together
    end

    accumulator

  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

end
