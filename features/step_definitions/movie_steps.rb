# Add a declarative step here for populating the DB with movies.
@count = 0

Given /the following movies exist/ do |movies_table|
  @count = movies_table.hashes.length
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |before_movie, after_movie|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"

  re = /#{before_movie}.*#{after_movie}/m
  assert page.body =~ re 

=begin #An Alternate way to acheive the above result
  begin
    element =  page.find("tbody", :text => re )
  rescue Capybara::ElementNotFound
    assert false
  end
  assert true  
=end  
  #warn "#{before_movie} #{after_movie} #{element.path} #{element.text} #{re}"
  #assert element != nil
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do
    |rating|
    if uncheck
      step %Q{I uncheck "ratings_#{rating}"}
    else
      step %Q{I check "ratings_#{rating}"}
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should( not)? see the following movies: (.*)/ do | not_see, movie_list|
  movie_list.split(", ").each do
    |movie_name|
    if not_see
      step %Q{I should not see "#{movie_name}"}
    else
      step %Q{I should see "#{movie_name}"}
    end
  end
end

Then /I should see all of the movies/ do
  num_rows = page.all(:css, "#movielist tr").length
  #warn "n = #{num_rows}, c = #{@count}"
  assert num_rows  == @count #one tr is for the headers
end  

Then /I should not see any of the movies/ do
  num_rows = page.all(:css, "#movielist tr").length
  #warn "n = #{num_rows}"
  assert num_rows  == 0
end 

#Then /I should see (.*) before (.*)/ do |before_movie, after_movie|
#end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  #warn " director = #{director}"
  step %Q{I should see "Director: #{director}"}
end    
