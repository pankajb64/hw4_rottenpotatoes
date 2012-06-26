require 'spec_helper'

describe MoviesController do

  before (:each) do
    @movie = Movie.create(:director => 'Rohit Shetty')
  end
  describe 'searching_with_similar_director' do
    it 'should call the method that finds movies with similar director' do
      Movie.should_receive(:movies_with_similar_director).with('Rohit Shetty')
      get :similar_director, :id => @movie
    end  
  end
end
