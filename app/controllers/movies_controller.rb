class MoviesController < ApplicationController
helper_method :sort_field, :sort_field_order

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    session[:home_path]=request.env["HTTP_REFERER"] unless session[:home_path]
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #Collecting ratings value if any
    @ratings=params[:ratings] ? params[:ratings] : session[:ratings]
    
    @rparams=@ratings ? @ratings : Movie.ratings
    
    if !params[:sort] && !params[:sorder] && !params[:ratings]
      redirect_to :action=>:index, :sort=>session[:sort], :sorder=>session[:sorder], :ratings=>session[:ratings]   
    end
    session.delete(:home_path)

    @filteredmovies=Movie.where(:rating=>@rparams)
    @movies =@filteredmovies.order(sort_field + " " + sort_field_order)
    @all_ratings=Movie.ratings
    session[:ratings]=@rparams
  end

  def new
    session[:home_path]=request.env["HTTP_REFERER"] unless session[:home_path]
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to session[:home_path]
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
    redirect_to session[:home_path]
  end
  
private
  
  def sort_field
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    session[:sort]=(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_field_order
    %w[asc desc].include?(params[:sorder]) ? params[:sorder] : "desc"
    session[:sorder]=(params[:sorder]) ? params[:sorder] : "desc"
  end
  
end
