require 'pry'
class Api::V1::FindersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_finder, only: [ :show, :update, :destroy ]

  def index
    # binding.pry
    @finders = policy_scope(Finder)
    @movies = Movie.where(finder_id: @finders)
  end

  def show

  end

   def update
    if @finder.update(finder_params)
      render :show
    else
      render_error
    end
  end

  def create
    @min_release = finder_params[:release][0..3].to_i
    @min_duration = finder_params[:duration].to_i
    @vote_count = 2500
    @min_rating = finder_params[:rating].first.to_i
    @max_rating = finder_params[:rating][1].to_i
    find_country(@min_release, @min_duration, @min_rating, @max_rating)
binding.pry
    @finder = Finder.new({"release"=> @min_release,
                          "duration"=>@min_duration,
                          "language"=>["French", @movie_title],
                          "rating"=>[@min_rating, @max_rating]})
                          # "title"=> @movie_title,
                          # "overview"=> @movie_overview,
                          # "vote_average"=> @movie_vote_average })

    @finder.user = current_user
    authorize @finder
    if @finder.save
      render :show, status: :created
    else
      render_error
    end
  end

    def destroy
    @finder.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end


  private

  def set_finder
    @finder = Finder.find(params[:id])
    authorize @finder  # For Pundit
  end


  def finder_params
    params.require(:finder).permit(:duration, :release, language: [], rating: [])
  end

  def render_error
    render json: { errors: @finder.errors.full_messages },
      status: :unprocessable_entity
  end

  def request_api(url)
    response = Excon.get(
      url)
    return nil if response.status != 200
    # binding.pry
    # p @bb = JSON.parse(response.body)
    @movie_title = JSON.parse(response.body)["results"][0]["original_title"]
    @movie_overview = JSON.parse(response.body)["results"][0]["overview"]
    @movie_vote_average = JSON.parse(response.body)["results"][0]["vote_average"]
    # @movie_title = JSON.parse(response.body)["results"][0]["original_title"]


  end
  def find_country(minrel, mindur, minrat, maxrat)
    key = "15d2ea6d0dc1d476efbca3eba2b9bbfb"
    request_api(
      "https://api.themoviedb.org/3/discover/movie?api_key=#{key}&include_adult=false&include_video=false&page=1&with_runtime.gte=#{mindur}&primary_release_date.gte=#{minrel}&vote_count.gte=2500&vote_average.gte=#{minrat}&vote_average.lte=#{maxrat}"
    )
  end
end


