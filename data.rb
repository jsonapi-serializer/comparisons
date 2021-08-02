require 'attr_extras'
require 'active_support/all'
require 'securerandom'
require 'ffaker'

class BaseModel
end

class Author < BaseModel
  vattr_initialize :id, :first_name, :last_name, :books, :book_ids
end
class Genre < BaseModel
  vattr_initialize :id, :title, :description, :books, :book_ids
end
class Book < BaseModel
  vattr_initialize(
    :id,
    :title,
    :description,
    :published_at,
    :authors,
    :author_ids,
    :genre,
    :genre_id
  )

  def sync
    author_ids = authors.map do |a|
      a.books << self
      a.book_ids << self.id
      a.id
    end
    genre_id = genre.id
    genre.books << self
    genre.book_ids << self.id

    self
  end
end

authors = (ENV['DATA_SIZE'] || 1000).to_i.times.map do
  Author.new(
    SecureRandom.uuid,
    FFaker::Name.first_name,
    FFaker::Name.last_name,
    [],
    []
  )
end

genres = 10.times.map do
  Genre.new(
    SecureRandom.uuid,
    FFaker::Book.genre,
    FFaker::Book.description,
    [],
    []
  )
end

DATA = (ENV['DATA_SIZE'] || 1000).to_i.times.map do
  Book.new(
    SecureRandom.uuid,
    FFaker::Book.title,
    FFaker::Book.description,
    FFaker::Time.datetime,
    authors.sample(rand(1..5)),
    [],
    genres.sample(),
    nil
  ).sync
end
