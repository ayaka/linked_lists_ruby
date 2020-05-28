require_relative "node.rb"

class LinkedList
  attr_reader :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def size
    return 0 if @head.nil?
    pointed = @head
    counter = 1
    until pointed == @tail
      pointed = pointed.next_node
      counter += 1
    end
    counter
  end
  
  def at(index)
    return nil if @head.nil? || index >= self.size || index < 0
    pointed = @head
    (1..index).each { |i| pointed = pointed.next_node }
    pointed
  end

  def pop 
    pointed = @head
    if pointed == @tail
      @head = nil
      @tail = nil
      pointed
    else
      pointed = pointed.next_node until pointed.next_node == @tail
      last_node = pointed.next_node
      pointed.next_node = nil
      @tail = pointed
      last_node.value
    end
  end

  def contains?(value)
    pointed = @head
    until pointed == nil
      return true if pointed.value == value
      pointed = pointed.next_node
    end
    false
  end

  def find(value)
    pointed = @head
    (0..self.size - 1).each do |index|
      return index if pointed.value == value
      pointed = pointed.next_node
    end
    nil    
  end

  def to_s
    pointed = @head
    string = ""
    until pointed == nil
      string += "#{pointed.value} -> "
      pointed = pointed.next_node
    end
    string += "nil"
  end

  def insert_at(value, index)
    return nil if (@head.nil? && index > 0) || index > self.size || index < 0
    node = Node.new(value)
    if index == 0
      self.prepend(value)
    elsif index == self.size
      self.append(value)
    else 
      pointed = @head
      (index - 1).times { pointed = pointed.next_node }
      node.next_node = pointed.next_node
      pointed.next_node = node
    end
  end

  def remove_at(index)
    return nil if index >= self.size || index < 0
    if index == 0 
      pointed = @head
      @head = @head.next_node
      @tail = nil if @head.nil?
      pointed.next_node = nil
      pointed
    elsif index == self.size - 1
      self.pop
    else
    pointed = @head
    (index - 1).times { pointed = pointed.next_node }
    pointed.next_node = pointed.next_node.next_node
    end
  end
end

linked_list = LinkedList.new

linked_list.append(3)
linked_list.append(4)
linked_list.append(7)
linked_list.append(9)
linked_list.append(12)
linked_list.append(15)

puts linked_list

linked_list.prepend(1)

puts linked_list

puts linked_list.size

puts linked_list.head.value
puts linked_list.tail.value

puts linked_list.at(2)
p linked_list.pop
puts linked_list.tail.value

puts linked_list.contains?(6)
puts linked_list.contains?(9)

puts linked_list.find(3)
p linked_list.find(15)

linked_list.insert_at(6, 3)
puts linked_list

p linked_list.remove_at(1)
puts linked_list

