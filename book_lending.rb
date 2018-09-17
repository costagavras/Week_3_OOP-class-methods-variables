require "pry"

class Book

  @@on_shelf = []
  @@on_loan = []
  @@overdue = []
  @@on_hold = [] # Stretch 2 array
  @@book_genre = [] # Stretch 3 array
  @@book_found_by_attribute = [] # Stretch 4 array

  def initialize(title, author, genre, isbn)
    @title = title
    @author = author
    @isbn = isbn
    @genre = genre
  end

  # Attribute Readers (getter) --------------------------------------

  def due_date
    @due_date
  end

  def title
    @title
  end

  def author
    @author
  end

  def isbn
    @isbn
  end

  def genre
    @genre
  end

  # Attribute Writers (setter) --------------------------------------

  def due_date=(due_date)
    @due_date = due_date
  end

  # Instance methods --------------------------------------

  def borrow
    if lent_out?
      puts "The book is already borrowed. I'll put it on hold for you." # Stretch 2
      @@on_hold << self # Stretch 2
      return false
    else
      self.due_date = Book.current_due_date
      @@on_shelf.delete(self)
      @@on_loan << self
      # move it from the collection of available books to the collection of books on loan
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
    if @@on_loan.include?(self) # self because acting on an instance *sister_outsider*
      return true
    else
      return false
    end

  end

  # Class methods --------------------------------------

  def self.create(title, author, genre, isbn)
    new_book = Book.new(title, author, genre, isbn)
    # puts new_book
    @@on_shelf << new_book
    # puts @@on_shelf
    return new_book
  end

  def self.current_due_date
    @due_date = Time.now + (2 * 7 * 24 * 60 * 60) # 2 weeks
  end

  # Stretch 1: Push the due date back on a given book
  def renew
    if @@on_loan.include?(self)
      puts "You cannot renew the book, it's on hold."
    else
      self.due_date = Time.now + (2 * 7 * 24 * 60 * 60) # 2 weeks
      puts "The book *#{title}* is now renewed for 2 weeks until: #{self.due_date}"
    end
  end

  def self.overdue
    # This class method should return a list of books whose due dates are in the past (ie. less than Time.now).
    puts "These are overdue:"
    @@on_loan.each do |book|
      if book.due_date < Time.now
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

  # Stretch 3 method
  def self.browse_by_genre
    i = 0
    puts "The following genres are available:"
    @@on_shelf.each do |book|
      if @@book_genre.include?(book.genre) == false
        @@book_genre << book.genre
        puts "#{i += 1}. #{book.genre}"
      end
    end
    i = 0
    puts
    puts "What is your choice?"
    user_selected = gets.chomp
    puts
    puts "Here is what we have in the selected genre:"
    @@on_shelf.each do |book|
      if book.genre == user_selected
        puts "#{i += 1}. #{book.inspect}"
      end
    end
  end

  # Stretch 4 class method
  def self.find_by_attribute(attribute_value)
    @@book_found_by_attribute = @@on_shelf.select { |book| book.title == attribute_value }
    if @@book_found_by_attribute.empty? == false
      puts @@book_found_by_attribute.inspect
    end
    @@book_found_by_attribute = @@on_shelf.select { |book| book.author == attribute_value }
    if @@book_found_by_attribute.empty? == false
      puts @@book_found_by_attribute.inspect
    end
# binding.pry
    @@book_found_by_attribute = @@on_shelf.select { |book| book.genre == attribute_value }
    if @@book_found_by_attribute.empty? == false
      puts @@book_found_by_attribute.inspect
    end
    @@book_found_by_attribute = @@on_shelf.select { |book| book.isbn == attribute_value }
    if @@book_found_by_attribute.empty? == false
      puts @@book_found_by_attribute.inspect
    end

  end

end

sister_outsider = Book.create("Sister Outsider", "Audre Lorde", "Psychology", "9781515905431")
aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", "Psychology", "9780896081307")
if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", "Science-fiction", "0893880221")

# puts Book.browse.inspect # #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221"> (this value may be different for you)
# puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
# puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
# puts Book.available.inspect # [#<Book:0x00555e82acde20 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431">, #<Book:0x00555e82acdce0 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
# puts Book.borrowed.inspect # []
# puts sister_outsider.lent_out? # false
# puts sister_outsider.borrow # true
# puts sister_outsider.lent_out? # true
# puts sister_outsider.borrow # Stretch 2: If someone tries to borrow a book and it's already on loan, find a way to indicate that the book has been put on hold. If a book is on hold you shouldn't be able to renew it.
# sister_outsider.renew # Stretch 2
# puts sister_outsider.due_date # 2017-02-25 20:52:20 -0500 (this value will be different for you)
# puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
# puts Book.borrowed.inspect # [#<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=2017-02-25 20:55:17 -0500>]
# puts Book.overdue.inspect # []
# puts sister_outsider.return_to_library # true
# puts sister_outsider.lent_out? # false
# puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">, #<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=nil>]
# puts Book.borrowed.inspect # []

# Stretch 1: renewal
# sister_outsider.renew

# Stretch 2 is built in the commands above, see comments.

# Stretch 3: Add a genre to each book and allow users to browse by genre.
# puts Book.available.inspect
# Book.browse_by_genre

# Stretch 4: Add a class method that accepts a title, author, or isbn as an argument and returns all books that match.
Book.find_by_attribute("Psychology")
