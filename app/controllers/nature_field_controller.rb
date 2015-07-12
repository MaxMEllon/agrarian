class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def action
    @area_node_id = params[:id]

    area_service_factory = AreaServiceFactory.new
    area = area_service_factory.build_by_area_node_id(@area_node_id)
    if(area.is_nil)
      redirect_to("/")
    end
  end
end
