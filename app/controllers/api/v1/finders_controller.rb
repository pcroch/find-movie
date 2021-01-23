class Api::V1::FindersController < Api::V1::BaseController
  def index
    @finders = policy_scope(Finder)
  end
end
