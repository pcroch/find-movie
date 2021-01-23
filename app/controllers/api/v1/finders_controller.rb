class Api::V1::FindersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_finder, only: [ :show, :update, :destroy ]

  def index
    @finders = policy_scope(Finder)
  end

  def show

  end

   def update
    if @finder.update(rfinder_params)
      render :show
    else
      render_error
    end
  end

  def create
    @finder = Finder.new(finder_params)
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
    params.require(:finder).permit(:duration, :release)
  end

  def render_error
    render json: { errors: @finder.errors.full_messages },
      status: :unprocessable_entity
  end


end
