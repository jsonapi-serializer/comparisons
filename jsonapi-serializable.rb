require 'jsonapi/serializable'

class AuthorSerializer < JSONAPI::Serializable::Resource
  type :author
  attributes :first_name, :last_name
  has_many :books
end

class GenreSerializer < JSONAPI::Serializable::Resource
  type :genre
  attributes :title, :description
  has_many :books
end

class BookSerializer < JSONAPI::Serializable::Resource
  type :book
  attributes :title, :description, :published_at
  has_many :authors
  belongs_to :genre
end

def run!
  JSONAPI::Serializable::Renderer.new.render(
    DATA.sample,
    class: {
      Author: AuthorSerializer,
      Genre: GenreSerializer,
      Book: BookSerializer
    }
  )
end

def run_many!
  JSONAPI::Serializable::Renderer.new.render(
    DATA,
    class: {
      Author: AuthorSerializer,
      Genre: GenreSerializer,
      Book: BookSerializer
    }
  )
end

def run_include_all!
  JSONAPI::Serializable::Renderer.new.render(
    DATA,
    class: {
      Author: AuthorSerializer,
      Genre: GenreSerializer,
      Book: BookSerializer
    },
    include: ['authors', 'genre']
  )
end

def run_include_deep!
  JSONAPI::Serializable::Renderer.new.render(
    DATA.sample,
    class: {
      Author: AuthorSerializer,
      Genre: GenreSerializer,
      Book: BookSerializer
    },
    include: [
      'authors',
      'authors.books',
      'authors.books.genre',
      'authors.books.genre.books',
      'authors.books.genre.books.authors',
      'authors.books.genre.books.genre'
    ]
  )
end
