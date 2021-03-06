class AreaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @id = params[:id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)

    # player
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    unless @player_character
      redirect_to '/player/input'
      return
    end

    resource_service_action_factory = ResourceActionServiceFactory.new(@player_character.player)
    resource_service_factory = ResourceServiceFactory.new
    factory = AreaServiceFactory.new(@player_character, resource_service_factory, resource_service_action_factory)

    @current = factory.build_by_area_node_id(@id)

    if @current.is_nil
      redirect_to '/areas/not_found'
      return
    end

    # その位置固有のアクションの実行
    @current.execute

    @can_move_to_next = @current.can_move_to_next

    # その位置でのターゲットを取得する。
    routes = Route.where('area_node_id = ?', @current.area_node.id)
    @target_routes = []
    routes.each do |route|
      @target_routes.push(factory.build_by_area_node_id(route.connected_area_node_id))
    end

    # nilじゃなかったら、each
    if @current.next_to_area_node_id
      @current.next_to_area_node_id.each do |area_node_id|
        @target_routes.push(factory.build_by_area_node_id(area_node_id))
      end
    end

    user_area = UserArea.get_or_create(@player_character.id)
    user_area.area_node_id = @id
    user_area.save
  end

  def not_found
  end
end

