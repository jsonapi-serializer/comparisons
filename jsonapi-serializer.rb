require 'jsonapi/serializer'

class AuthorSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name
  has_many :books
end

class GenreSerializer
  include JSONAPI::Serializer

  attributes :title, :description
  has_many :books
end

class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :published_at
  has_many :authors
  belongs_to :genre
end

def run!
  BookSerializer.new(DATA.sample).serializable_hash
end

def run_many!
  BookSerializer.new(DATA, is_collection: true).serializable_hash
end

def run_include_all!
  BookSerializer.new(
    DATA,
    is_collection: true,
    include: ['authors', 'genre']
  ).serializable_hash
end

def run_include_deep!
  BookSerializer.new(
    DATA.sample,
    include: [
      'authors',
      'authors.books',
      'authors.books.genre',
      'authors.books.genre.books',
      'authors.books.genre.books.authors',
      'authors.books.genre.books.genre'
    ]
  ).serializable_hash
end
