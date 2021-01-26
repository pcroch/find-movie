require 'pry'
class Api::V1::FindersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_finder, only: [ :show, :update, :destroy ]

  def index

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
    get_genre_id
    @min_release = finder_params[:release][0..3].to_i
    @min_duration = finder_params[:duration].to_i
    @vote_count = 100
    @min_rating = finder_params[:rating].first.to_i
    @max_rating = finder_params[:rating][1].to_i

    # find the matching preferences
# https://stackoverflow.com/questions/5128200/how-to-count-identical-string-elements-in-a-ruby-array
          i = 0
          j = (finder_params["attendees"].count)
          @preferences = []
      while i < j
        # find the name of the tteendes and extract them
        name = finder_params["attendees"][i]
        tmp = Preference.where(name: name)[0][:content]
        tmp.each{|string| @preferences.append(string) }
        counts = Hash.new(0)
        @preferences.each { |preference| counts[preference] += 1 }
        # count number of self occurance and sort it Desc
        counts = @preferences.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
        choice = counts.max_by{|k,v| v}
               # I hav thepref to filter
        @genre = @genre_hash[choice[0].to_sym]

        #get the id




        i += 1

      end


    find_country(@min_release, @min_duration, @vote_count, @min_rating, @max_rating, @genre)

    @finder = Finder.new({"release"=> @min_release,
                          "duration"=>@min_duration,
                          "language"=>["French", @movie_title],
                          "rating"=>[@min_rating, @max_rating] })
    @finder.user = current_user
    authorize @finder
    if @finder.save

      i = 0
      # binding.pry
      @body["results"].count < 10 ? upper_limit = @body["results"].count : upper_limit = 10
      while i < upper_limit
        movie = Movie.new({"finder_id" => @finder.id,
                        "title"=> @body["results"][i]["original_title"],
                        "overview"=> @body["results"][i]["overview"],
                        "vote_average"=> @body["results"][i]["vote_average"] })
        movie.save
        i += 1
      end
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
    params.require(:finder).permit(:duration, :release, language: [], rating: [], attendees: [])
  end

  def render_error
    render json: { errors: @finder.errors.full_messages },status: :unprocessable_entity
  end

  def get_genre_id
    # @genre_id = JSON.parse(Excon.get("https://api.themoviedb.org/3/genre/movie/list?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&language=en-US").body)["genres"]
    @genre_hash = { Action: 28, Adventure: 12, Animation: 12, Comedy: 35, Crime: 80,
                    Documentary: 99, Drama: 18, Family: 10_751, Fantasy: 14, History: 36, Horror: 27,
                    Music: 10_402, Mystery: 9648, Romance: 10_749, Science_Fiction: 878, TV_Movie: 10_770,
                    Thriller: 53, War: 10_752, Western: 37 }
  end

  def request_api(url)
    response = Excon.get(url)
    return nil if response.status != 200

    @body = JSON.parse(response.body)

  end

  def find_country(minrel, mindur, vote, minrat, maxrat, gen)
    key = "15d2ea6d0dc1d476efbca3eba2b9bbfb"
    request_api(
      "https://api.themoviedb.org/3/discover/movie?api_key=#{key}&page=1&with_genres=#{gen}&with_runtime.gte=#{mindur}&primary_release_date.gte=#{minrel}&vote_count.gte=#{vote}&vote_average.gte=#{minrat}&vote_average.lte=#{maxrat}?"
    )

  end
end


