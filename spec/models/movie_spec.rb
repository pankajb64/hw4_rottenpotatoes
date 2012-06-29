require 'spec_helper'
=begin
FactoryGirl.define do
  factory :movie do
    title 'Hula Hula'
    rating 'PG'
    director 'Rohit Shetty'
    release_date { 2.years.ago }
  end
end
=end
    
describe Movie do
  #pending "add some examples to (or delete) #{__FILE__}"
  before (:each) do
    @movie = Movie.create(:director => 'Rohit Shetty')
    @m1 = Movie.create(:director => 'Rohit Shetty')
    @m2 = Movie.create(:director => 'Rohit Shetty')
    @fake_movies = [ @movie, @m1, @m2 ]
    #Movie.stub(:find_all_by_director).and_return(@fake_movies)
  end
    
  describe "find movies with similar director" do

    it 'should find the movie with the given id' do
      Movie.should_receive(:find_by_id).with(@movie.id).and_return(@movie)
      Movie.movies_with_similar_director(@movie.id)
    end  
 
    it 'should find all movies with the given director' do
      Movie.should_receive(:find_all_by_director).with(@movie.director).and_return(@fake_movies)
      Movie.movies_with_similar_director(@movie.id)
    end
    
    it 'should return all movies except the supplied movie' do
      #Movie.stub(:find_all_by_director).and_return(@fake_movies)
      @fake_movies.delete(@movie) 
      Movie.movies_with_similar_director(@movie.id).should == @fake_movies
    end  
end 
  
end
