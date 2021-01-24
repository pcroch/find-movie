require 'pry'
class Api::V1::FindersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_finder, only: [ :show, :update, :destroy ]

  def index
    @finders = policy_scope(Finder)
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
    # binding.pry
    a = finder_params[:duration].first.to_i
    # b = finder_params[:release].first.to_i
    find_country(a)
    # countries = find_country(finder_params)
    # take the params


    # fetch the api movie

    # create the object finder with the result
    @finder = Finder.new({"release"=>"2012", "duration"=>@aa, "language"=>["French", "English"], "rating"=>["5", "9"]})
# binding.pry
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
      url,
      headers: {
        # 'X-RapidAPI-Host' => URI.parse(url).host,
        # 'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    return nil if response.status != 200
    # binding.pry
    p JSON.parse(response.body)
    @aa = JSON.parse(response.body)["status"]

  end
  def find_country(rel)
    request_api(
      "https://bomus-malus.herokuapp.com/api/v4/scores?sinister[]=#{rel}&years[]=1&pro[]=1"
    )
  end
end
