class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    result = Location.search(search_params[:q], search_params)

    locations = result.map do |r|
      r.merge(r.delete('_source')).merge('id': r.delete('_id'))
    end

    render json: { locations: locations }, status: :ok
  end

  private

  def search_params
    params.permit(:q, :level)
  end
end
