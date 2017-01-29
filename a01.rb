class Array

  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self[0]
  end

  def my_map
    res_arr = []
    self.each do |el|
      res_arr << yield(el)
    end
    res_arr
  end

  def my_select
    res_arr = []
    self.each do |el|
      res_arr << el if yield(el)
    end
    res_arr
  end

  def my_reject
    res_arr = []
    self.each do |el|
      res_arr << el unless yield(el)
    end
    res_arr
  end

  def my_any?
    self.each do |el|
      return true if yield(el)
    end
    false
  end

  def my_all?
    sekf.each do |el|
      return false unless yield(el)
    end
    true
  end

end
