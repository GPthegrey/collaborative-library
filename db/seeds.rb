print 'destroying all'

Loan.destroy_all
Book.destroy_all
Bookclub.destroy_all
Event.destroy_all
Review.destroy_all
Chatroom.destroy_all
User.destroy_all

User.create(email: 'guido@mail.com', password: '123456', nickname: 'Guido', address: 'Ugarte 2622, Belgrano, CABA, Argentina')
User.create(email: 'juan@mail.com', password: '123456', nickname: 'Juan', address: 'Gran Via 719, Barcelona, España')

print 'Users created'

books = [
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    description: "The hero-narrator of The Catcher in the Rye is an ancient child of sixteen, a native New Yorker named Holden Caulfield. Through circumstances that tend to preclude adult, secondhand description, he leaves his prep school in Pennsylvania and goes underground in New York City for three days.",
    genre: "Novela",
    language: "English",
    user_id: User.first.id,
    status: "Available"
  },
  {
    title: "1984",
    author: "George Orwell",
    description: "The story of Winston Smith begins on 4 April 1984: It was a bright cold day in April, and the clocks were striking thirteen. Yet he is uncertain of the true date, given the regime's continual rewriting and manipulation of history. Smith is a diligent and skillful worker, but he secretly hates the Party and dreams of rebellion against Big Brother.",
    genre: "Novela",
    language: "English",
    user_id: User.first.id,
    status: "Available"
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    description: "The story, told by the six-year-old Jean Louise Finch, takes place during three years (1933–35) of the Great Depression in the fictional town of Maycomb, Alabama, the seat of Maycomb County. Jean Louise Finch, nicknamed Scout, lives with her older brother Jeremy, nicknamed Jem, and their widowed father Atticus, a middle-aged lawyer.",
    genre: "Novela",
    language: "Spanish",
    user_id: User.first.id,
    status: "Available"
  },
  {
    title: 'Roma soy yo',
    author:'Santiago Posteguillo',
    description: 'Historia de Cesar',
    genre: 'Novela Historica',
    language: 'Spanish',
    user_id: User.last.id,
    status: "Available"
  },
  {
    title: 'El Asesinato de Socrates',
    author:'Marcos Chicot',
    description: 'Historia de Socrates',
    genre: 'Novela Historica',
    language: 'Spanish',
    user_id: User.last.id,
    status: "Available"
  }
]

books.each do |book|
  Book.create(book)
  print 'book created'
end
