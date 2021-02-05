# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, exept: [:home]

  def home
    render json: { Finder_movie: 'This is an api please refer to the documentation', status: :error }
  end
end
