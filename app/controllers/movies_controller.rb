class MoviesController < ApplicationController

  def update
    movie = Movie.find_by(:id => params["id"])
    movie.title = params[:title]
    movie.year = params[:year]
    movie.save
    redirect_to root_url
  end

  def edit
    @movie = Movie.find_by(:id => params["id"])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new
    @movie.title = params["title"]
    @movie.year = params["year"]
    if @movie.save
      redirect_to root_url # "/"
    else
      render 'new'
    end
  end

  def index
    if params["keyword"].present?
      k = params["keyword"].strip
      @movies = Movie.where("title LIKE '%#{k}%'")
    else
      @movies = Movie.all
    end

    respond_to do |format|
      format.html do
        render 'index'
      end
      format.json do
        render :json => @movies
      end
      format.xml do
        render :xml => @movies
      end
    end

  end

  def destroy
    @movie = Movie.find_by(:id => params["id"])
    @movie.delete
    redirect_to "/movies"
  end

  def show
    @movie = Movie.find_by(:id => params["id"])
    cookies["movie_id"] = @movie.id
  end

end
