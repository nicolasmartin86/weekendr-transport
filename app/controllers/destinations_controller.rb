class DestinationsController < ApplicationController
  def index
    @destinations_asked = Destination.where(destination_name: Destination.destinations_asked).order(destination_name: :asc)
    @destinations = Destination.where.not(destination_name: Destination.destinations_asked).order(destination_name: :asc)
  end
end
