# frozen_string_literal: true
module Api
  module V1
    class FindersController < Api::V1::BaseController
      acts_as_token_authentication_handler_for User, except: %i[index show]
      before_action :set_finder, only: %i[show update destroy]

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
        # render json: { error: "No movie found" }, status: :not_found if finder_params[:rating].nil?

        @hash_params = { min_release: finder_params[:release],
                         min_duration: finder_params[:duration],
                         vote_count: 100,
                         min_rating: finder_params[:rating].min,
                         max_rating: finder_params[:rating].max,
                         genre: nil }

        matching_preferences
        choice_count

        @finder = Finder.new({ 'release' => @hash_params[:min_release],
                               'duration' => @hash_params[:min_duration],
                               'language' => ['N/A'],
                               'rating' => [@hash_params[:min_rating], @hash_params[:max_rating]] })
        @finder.user = current_user
        authorize @finder

        find_country(@hash_params[:min_release],
                     @hash_params[:min_duration],
                     @hash_params[:vote_count],
                     @hash_params[:min_rating],
                     @hash_params[:max_rating],
                     @hash_params[:genre])

        if @finder.save
          upper_limit
        else
          render_error
        end
      end

      def destroy
        @finder.destroy
        head :no_content # No need to create a `destroy.json.jbuilder` view
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

      def matching_preferences
        # find the matching preferences
        i = 0
        j = finder_params['attendees'].count
        @preferences = []
        while i < j

          # find the name in the params for i
          name = finder_params['attendees'][i]
          # find the name of the user in preference for i
          tmp = Preference.where(name: name)[0][:content]
          # creating a temporary varaible to create an array to sock the preferences
          tmp.each { |string| @preferences.append(string) }
          # creating the hash that will count the number of ocurance for each movie category
          @counts = Hash.new(0)
          # create an has: count with the number of ocurance for each movie category
          @counts = @preferences.each_with_object(Hash.new(0)) { |e, total| total[e] += 1 }
          i += 1
        end
      end

      def upper_limit
        # validation if empty of nil to avoid to crash the api
        if @body.nil? || @body['results'].count.zero?
          empty_request # call emtpy request method in parent
        else
          # selecting a maximum of 10 movies or less
          @body['results'].count < 10 ? (upper_limit = @body['results'].count) : (upper_limit = 10)
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
        @genre_hash = { Action: 28, Adventure: 12, Animation: 12, Comedy: 35, Crime: 80,
                        Documentary: 99, Drama: 18, Family: 10_751, Fantasy: 14, History: 36, Horror: 27,
                        Music: 10_402, Mystery: 9648, Romance: 10_749, Science_Fiction: 878, TV_Movie: 10_770,
                        Thriller: 53, War: 10_752, Western: 37 }

        choice = @counts.max_by { |_k, v| v }
        @hash_params[:genre] = @genre_hash[choice[0].to_sym]
        # Pop first item of the array which is the choice
        @counts.shift # useless for now and forever probably
      end

      def find_country(minrel, mindur, vote, minrat, maxrat, gen)
        minrel_full = "#{minrel}-01-01"
        key = '15d2ea6d0dc1d476efbca3eba2b9bbfb'
        url = "https://api.themoviedb.org/3/discover/movie?api_key=#{key}&page=1&with_genres=#{gen}&vote_average.gte=#{minrat}&vote_average.lte=#{maxrat}&with_runtime.gte=#{mindur}&primary_release_date.gte=#{minrel_full}&vote_count.gte=#{vote}"
        response = Excon.get(url)
        @body = JSON.parse(response.body)
      end
    end
  end
end

