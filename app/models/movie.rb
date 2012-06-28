class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.movies_with_similar_director ( id )
    movie = find_by_id(id)
    movies = find_all_by_director(movie.director)
    movies.delete(movie)
    return movies
  end
  
end
