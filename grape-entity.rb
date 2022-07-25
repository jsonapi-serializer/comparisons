require 'grape-entity'

class BookEntity < Grape::Entity; end;

class AuthorEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: 'use for retrieve author internally' }
  expose :first_name, documentation: { type: 'String', desc: 'Authors first name' }
  expose :last_name, documentation: { type: 'String', desc: 'Authors last name' }

  expose :books, using: ::BookEntity
end

class GenreEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: 'use for retrieve author internally' }
  expose :title, documentation: { type: 'String', desc: 'Genre title' }
  expose :description, documentation: { type: 'String', desc: 'Genre detailed description' }

  expose :books, using: ::BookEntity
end

class BookEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: 'use for retrieve author internally' }
  expose :title, documentation: { type: 'String', desc: 'Book title' }
  expose :description, documentation: { type: 'String', desc: 'Book detailed description' }
  expose :published_at, documentation: { type: 'String', desc: 'Book detailed description' }

  expose :authors
  expose :genre
end

def run!
  BookEntity.represent(DATA, serializable: true, only: %i[id title description published_at])
end

def run_many!
  BookEntity.represent(
    DATA,
    serializable: true,
    only: [:id, :title, :description, :published_at,
           { authors: %i[id first_name last_name] },
    ]
  )
end

def run_include_all!
  BookEntity.represent(
    DATA,
    serializable: true,
    only: [:id, :title, :description, :published_at,
           { authors: %i[id first_name last_name] },
           { genre: %i[id title description] }
    ]
  )
end

def run_include_deep!
  BookEntity.represent(
    DATA,
    serializable: true,
    only: [:id, :title, :description, :published_at,
           {
             authors: [:id, :first_name, :last_name,
                       { books: [:id, :title, :description, :published_at,
                                 { genre: [:id, :title, :description,
                                           { books: [:id, :title, :description, :published_at,
                                                     { authors: %i[id first_name last_name],
                                                       genre: %i[id first_name last_name] }] }] }] }]
           },
           { genre: %i[id title description] }
    ]
  )
end