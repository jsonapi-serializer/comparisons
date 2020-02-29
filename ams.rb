require 'active_model_serializers'

ActiveModelSerializers.config.adapter = :json_api

class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :books
end

class GenreSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_many :books
end

class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_at
  has_many :authors
  belongs_to :genre
end

def run!
  ActiveModelSerializers::SerializableResource
    .new(DATA.sample).serializable_hash
end

def run_many!
  ActiveModelSerializers::SerializableResource
    .new(DATA).serializable_hash
end

def run_include_all!
  ActiveModelSerializers::SerializableResource.new(
    DATA,
    include: ['authors', 'genre']
  ).serializable_hash
end
