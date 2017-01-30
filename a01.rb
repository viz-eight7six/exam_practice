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
    self.each do |el|
      return false unless yield(el)
    end
    true
  end

  def my_none?
    self.each do |el|
      return false if yield(el)
    end
    true
  end

  def my_flatten
    res_arr = []
    self.each do |el|
      if el.is_a?(Array)
        res_arr += el.my_flatten
      else
        res_arr << el
      end
    end

    res_arr
  end

  def my_zip(*args)
    res_arr = []
    self.each_with_index do |el, idx|
      el_arr = [el]
      args.each do |arg|
        el_arr << arg[idx]
      end
      res_arr << el_arr
    end
    res_arr
  end

  def my_rotate(num = 1)
    res_arr = Array.new(self.length)
    self.each_with_index do |el, idx|
      res_arr[idx - num] = el
    end
    res_arr
  end

  def my_join(sep = '')
    res_str = ''
    self.each do |el|
      res_str += el.to_s
      res_str += sep unless self.last == el
    end
    res_str
  end

  def my_reverse
    res_arr = []
    self.each do |el|
      res_arr.insert(0, el)
    end
    res_arr
  end

  def my_inject(acc = nil)
    use_arr = (acc.nil? ? self[1..-1] : self)
    acc ||= self.first
    use_arr.each do |el|
      acc = yield(acc, el)
    end
    acc
  end

  def my_transpose
    res_arr = Array.new(self.first.length) { [] }
    self.each do |sub_arr|
      sub_arr.each_with_index do |el, idx2|
        res_arr[idx2] << el
      end
    end
    res_arr
  end


  def bubble_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    sorted = false
    swap = false
    until sorted
      swap = false
      self.each_index do |idx|
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          swap = true
        end
      end
      sorted = true if swap == false
    end
    self
  end

  def quick_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = self[self.length / 2]
    return self if self.length <= 1
    left_arr = []
    right_arr = []
    same_arr = []
    self.each do |el|
      if prc.call(pivot, el) == -1
        right_arr << el
      elsif prc.call(pivot, el) == 0
        same_arr << el
      else
        left_arr << el
      end
    end
    left_arr.quick_sort + same_arr + right_arr.quick_sort
  end

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if self.length <= 1
    left_arr = [0...self.length / 2].merge_sort(&prc)
    right_arr = [self.length / 2..-1].merge_sort(&prc)
    Array.merge(left_arr, right_arr, &prc)


  end

  def self.merge(left_arr, right_arr, &prc)
    res_arr = []
    if prc.call(left_arr, right_arr) == -1
      res_arr = left_arr + right_arr
    elsif prc.call(pivot, el) == 0
      res_arr = left_arr + right_arr
    else
      res_arr = rigth_arr + left_arr
    end
    res_arr

  end

  def deep_dup
    res_arr = []
    self.each do |el|
      if el.is_a?(Array)
        res_arr << el.deep_dup
      else
        res_arr << el
      end
    end
    res_arr
  end

  def subsets
    res_arr = [[]]
    return res_arr if self.empty?
    part_arr = self[0...-1].subsets
    part_arr + part_arr.map { |el| el + [self.last] }
  end


end
