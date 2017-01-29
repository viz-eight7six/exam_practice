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


end
