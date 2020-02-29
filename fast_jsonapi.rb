require 'fast_jsonapi'

class AuthorSerializer
  include FastJsonapi::ObjectSerializer

  set_type :author
  set_id :id
  attributes :first_name, :last_name
  has_many :books
end

class GenreSerializer
  include FastJsonapi::ObjectSerializer

  set_type :genre
  set_id :id
  attributes :title, :description
  has_many :books
end

class BookSerializer
  include FastJsonapi::ObjectSerializer

  set_type :book
  set_id :id
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
