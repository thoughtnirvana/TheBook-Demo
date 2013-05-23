# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user1 = User.find_by_email("test1@test.com")
if !user1
  user1 = User.new
  user1.email = "test1@test.com"
  user1.name = "testuser1"
  user1.password = "test123"
  user1.password_confirmation = "test123"
  user1.save!
end

user2 = User.find_by_email("test2@test.com")
if !user2
  user2 = User.new
  user2.email = "test2@test.com"
  user2.name = "testuser2"
  user2.password = "test123"
  user2.password_confirmation = "test123"
  user2.save!
end

admin = User.find_by_email("admin@test.com")
if !admin
  admin = User.new
  admin.email = "admin@test.com"
  admin.name = "admin"
  admin.password = "test123"
  admin.password = "test123"
  admin.admin = true
  admin.save!
end

book1 = Book.find_or_create_by_isbn!(title: "Brave New World", author: "Aldous Huxley", isbn: "0061767646")
book2 = Book.find_or_create_by_isbn!(title: "Animal Farm", author: "George Orwell", isbn: "1412811902")
book3 = Book.find_or_create_by_isbn!(title: "Fahrenheit 451: A Novel", author: "Ray Bradbury", isbn: "1451673310")
book4 = Book.find_or_create_by_isbn!(title: "The Wolves of Midwinter", author: "Anne Rice", isbn: "0385349963")
book5 = Book.find_or_create_by_isbn!(title: "The Fountainhead", author: "Ayn Rand", isbn: "0451099567")
book6 = Book.find_or_create_by_isbn!(title: "Atlas Shrugged", author: "Ayn Rand", isbn: "0786194014")
Book.find_or_create_by_isbn!(title: "Book1", author: "Author1", isbn: "1234123981")
Book.find_or_create_by_isbn!(title: "Book2", author: "Author2", isbn: "1234433981")
Book.find_or_create_by_isbn!(title: "Book3", author: "Author3", isbn: "1234123111")
Book.find_or_create_by_isbn!(title: "Book4", author: "Author4", isbn: "1564123981")

Rating.find_or_create_by_user_id_and_book_id!(book_id: book1.id, user_id: user1.id)
Rating.find_or_create_by_user_id_and_book_id!(book_id: book2.id, user_id: user2.id)
Rating.find_or_create_by_user_id_and_book_id!(book_id: book3.id, user_id: user1.id)
Rating.find_or_create_by_user_id_and_book_id!(book_id: book4.id, user_id: user2.id)
Rating.find_or_create_by_user_id_and_book_id!(book_id: book5.id, user_id: user1.id)
Rating.find_or_create_by_user_id_and_book_id!(book_id: book6.id, user_id: user2.id)


