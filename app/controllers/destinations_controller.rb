class DestinationsController < ApplicationController
  def index
    @destinations_asked = Destination.where(destination_name: Destination.destinations_asked)
    @destinations = Destination.where.not(destination_name: Destination.destinations_asked)
  end
end
