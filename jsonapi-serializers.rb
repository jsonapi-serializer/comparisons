require 'jsonapi-serializers'

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
  has_one :genre
end

def run!
  JSONAPI::Serializer.serialize(DATA.sample)
end

def run_many!
  JSONAPI::Serializer.serialize(DATA, is_collection: true)
end

def run_include_all!
  JSONAPI::Serializer.serialize(
    DATA,
    is_collection: true,
    include: ['authors', 'genre']
  )
end
