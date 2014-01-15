class SortedArray
  attr_reader :internal_arr

  def initialize new_array=[]
    @internal_arr = []
    new_array.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block
  # loop over all elements in @internal_arr
  # yield to each element  in that array
  # keep track of index
    i = 0
    while i < @internal_arr.size
      yield @internal_arr[i]
      i += 1
    end
    return @internal_arr  
  end

  def map &block
    # invokes the given block for each element of self
    # creates a new array containing the values returned by the block
    new_array = []
    i = 0
    each do |el|
      new_array[i] = yield(el)
      i += 1
    end
    return new_array
  end
    
  def map! &block
    i = 0
    each do |el|
      @internal_arr[i] = block.call(el)
      i += 1
    end
    return @internal_arr
  end

  def find &block
    # returns a block that tests for equality, find 3 should return true when it finds 3, at that point it stops yielding
    value = nil
    i = 0
    each do |el|
      value = @internal_arr[i] if yield el
      i += 1
    end
    return value
  end

  def inject acc=nil, &block
    index = acc.nil? ? 1 : 0 
    acc = @internal_arr[0] if acc.nil?
    while index <= @internal_arr.length-1
      acc = yield acc, @internal_arr[index]
      index += 1
    end
    acc
  end

end