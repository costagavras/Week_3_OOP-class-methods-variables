
class Book

  @@on_shelf = []
  @@on_loan = []
  @@overdue = []

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  # Attribute Readers (getter) --------------------------------------

  def due_date
      @due_date
  end

  # Attribute Writers (setter) --------------------------------------

  def due_date=(due_date)
      @due_date = due_date
  end

  # Instance methods --------------------------------------

  def borrow
    if lent_out?
        return false
    else
        self.due_date = Book.current_due_date #calling class method to act on an instance
        @@on_shelf.delete(self)
        @@on_loan << self
        #move it from the collection of available books to the collection of books on loan
        return true
    end
  end

  def return_to_library
    # This instance method is how a book gets returned to the library. It should call lent_out? to verify that the book was actually on loan.
    # If it wasn't on loan in the first place, return false. Otherwise, move the book from the collection of books on loan
    # to the collection of books on the library shelves, and set the book's due date to nil before returning true.
    if lent_out?
      @@on_loan.delete(self)
      @@on_shelf << self
      self.due_date = nil
      return true
    else
      return false
    end
  end

  def lent_out?
    # This instance method return true if a book has already been borrowed and false otherwise.
    # if book is in the array @@on_loan return true
    if @@on_loan.include?(self) #self because acting on an instance @sister_outsider@
        return true
      else
        return false
    end

  end

  # Class methods --------------------------------------

  def self.create(title, author, isbn)
    new_book = Book.new(title, author, isbn)
    # puts new_book
    @@on_shelf << new_book
    puts @@on_shelf
  return new_book
  end

  def self.current_due_date
    @due_date = Time.now + (2*7*24*60*60) # 2 weeks
  end

  def self.overdue
    # This class method should return a list of books whose due dates are in the past (ie. less than Time.now).
    puts "These are overdue:"
    @@on_loan.each do |book|
             if book.due_date  < Time.now
                @@overdue << book
              end
    end
    return @@overdue
  end

  def self.browse
    # This class method should return a random book from @@on_shelf
    # (you may need to consult the Array docs to figure out how to do this).
    puts "Browse random books:"
    return @@on_shelf.sample
  end

  def self.available
    puts "These books are available:"
      return @@on_shelf
  end

  def self.borrowed
    puts "These are borrowed:"
      return @@on_loan
  end


end

sister_outsider = Book.create("Sister Outsider", "Audre Lorde", "9781515905431")
aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", "9780896081307")
if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", "0893880221")

puts Book.browse.inspect # #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.available.inspect # [#<Book:0x00555e82acde20 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431">, #<Book:0x00555e82acdce0 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # []
puts sister_outsider.lent_out?
puts sister_outsider.lent_out? # false
puts sister_outsider.borrow # true
puts sister_outsider.lent_out? # true
puts sister_outsider.borrow # false
puts sister_outsider.due_date # 2017-02-25 20:52:20 -0500 (this value will be different for you)
puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # [#<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=2017-02-25 20:55:17 -0500>]
puts Book.overdue.inspect # []
puts sister_outsider.return_to_library # true
puts sister_outsider.lent_out? # false
puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">, #<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=nil>]
puts Book.borrowed.inspect # []
