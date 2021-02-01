class Api::V1::FindersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index, :show]
  before_action :set_finder, only: [:show, :update, :destroy]

  def index
    @finders = policy_scope(Finder)

    @movies = Movie.where(finder_id: @finders)
  end

  def show; end

  def update
    if @finder.update(finder_params)
      render :show
    else
      render_error
    end
  end

  def create
    find_genre_id
    hash_params = { min_release: finder_params[:release],
                    min_duration: finder_params[:duration],
                    vote_count: 100,
                    min_rating: finder_params[:rating].min,
                    max_rating: finder_params[:rating].max }
    matching_preferences
    choice_count

    find_country(hash_params[:min_release],
                 hash_params[:min_duration],
                 hash_params[:vote_count],
                 hash_params[:min_rating],
                 hash_params[:max_rating],
                 hash_params[:genre])

    @finder = Finder.new({ 'release' => hash_params[:min_release],
                           'duration' => hash_params[:min_duration],
                           'language' => ["French", hash_params[:movie_title]],
                           'rating' => [hash_params[:min_rating], hash_params[:max_rating]] })
    @finder.user = current_user
    authorize @finder
    if @finder.save
      upper_limit
    # while @body["results"].count < 10
    #   @vote_count -= 10

    # end

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

  # security methods
  def set_finder
    @finder = Finder.find(params[:id])
    authorize @finder # For Pundit
  end

  def finder_params
    params.require(:finder).permit(:duration, :release, language: [], rating: [], attendees: [])
  end

  def render_error
    render json: { errors: @finder.errors.full_messages }, status: :unprocessable_entity
  end

  def find_genre_id
    # @genre_id = JSON.parse(Excon.get("https://api.themoviedb.org/3/genre/movie/list?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&language=en-US").body)["genres"]
    @genre_hash = { Action: 28, Adventure: 12, Animation: 12, Comedy: 35, Crime: 80,
                    Documentary: 99, Drama: 18, Family: 10_751, Fantasy: 14, History: 36, Horror: 27,
                    Music: 10_402, Mystery: 9648, Romance: 10_749, Science_Fiction: 878, TV_Movie: 10_770,
                    Thriller: 53, War: 10_752, Western: 37 }
  end

  def matching_preferences
    # find the matching preferences
    i = 0
    j = (finder_params['attendees'].count)
    @preferences = []
    while i < j
      # find the name of the tteendes and extract them
      name = finder_params['attendees'][i]
      tmp = Preference.where(name: name)[0][:content]
      tmp.each { |string| @preferences.append(string) }
      @counts = Hash.new(0)
      @preferences.each { |preference| @counts[preference] += 1 }
      @counts = @preferences.inject(Hash.new(0)) { |total, e| total[e] += 1; total }
      i += 1
    end
  end

  def upper_limit
    if @body['results'].count.zero?
      empty_request # call emtpy request method in parent

    else
      @body['results'].count < 10 ? (upper_limit = body['results'].count) : (upper_limit = 10)
      i = 0
      # while i < 10
      while i < upper_limit
        movie = Movie.new({ 'finder_id' => @finder.id,
                            'title' => @body['results'][i]['original_title'],
                            'overview' => @body['results'][i]['overview'],
                            'vote_average' => @body['results'][i]['vote_average'] })
        movie.save
        i += 1
      end
      render :show, status: :created
    end
  end

  def choice_count
    choice = @counts.max_by { |_k, v| v }
    @genre = @genre_hash[choice[0].to_sym]
    # Following line to be change
    # @counts.delete("Horror")_
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


