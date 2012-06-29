require 'spec_helper'

describe MoviesController do

  before (:each) do
    @movie = Movie.create(:director => 'Rohit Shetty')
    @m1 = Movie.create(:director => 'Rohit Shetty')
  end
  describe 'searching_with_similar_director' do
    it 'should call the method that finds movies with similar director' do
      Movie.should_receive(:movies_with_similar_director).with(@movie.id.to_s)
      get :similar_director, :id => @movie
    end
    
    it 'should select the Similar Director template for rendering' do
      Movie.stub(:movies_with_similar_director).and_return([@m1])
      get :similar_director, :id => @movie
      response.should render_template('similar_director')
    end
    
    it 'should make search results available to that template' do
      fake_results = [ mock('Movie'), mock('Movie') ]
      Movie.stub(:movies_with_similar_director).and_return(fake_results)
      get :similar_director, :id => @movie
      # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
    
    it 'should redirect to the home page if director info is nill' do
      @movie.director = nil
      @movie.save!
      get :similar_director, :id => @movie
      response.should redirect_to(movies_path)
    end    
  end
end
