class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    render json: { Bonus_Malus_Score: "This is an api please refer to the documentation", status: :error }

  end
end
