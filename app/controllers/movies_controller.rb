class MoviesController < ApplicationController
helper_method :sort_field, :sort_field_order

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #Collecting ratings value if any
    @rparams=params[:ratings] ? params[:ratings] : Movie.ratings
    @filteredmovies=Movie.where(:rating=>@rparams)
    @movies =@filteredmovies.order(sort_field + " " + sort_field_order)
    @all_ratings=Movie.ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
private
  
  def sort_field
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_field_order
    %w[asc desc].include?(params[:sorder]) ? params[:sorder] : "desc"
  end
  
  def ratings_filter
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
