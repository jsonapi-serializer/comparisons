require 'securerandom'
require 'ffaker'

Author = Struct.new(:id, :first_name, :last_name, :books, :book_ids)
Genre = Struct.new(:id, :title, :description, :books, :book_ids)
Book = Struct.new(
  :id,
  :title,
  :description,
  :published_at,
  :authors,
  :author_ids,
  :genre,
  :genre_id
) do

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

authors = (ENV['DATA_SIZE'] || 1000).times.map do
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

DATA = (ENV['DATA_SIZE'] || 1000).times.map do
  Book.new(
    SecureRandom.uuid,
    FFaker::Book.title,
    FFaker::Book.description,
    FFaker::Time.datetime,
    authors.sample(rand(1..5)),
    [],
    genres.sample()
  ).sync
end
