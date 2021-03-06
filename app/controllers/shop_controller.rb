class ShopController < ApplicationController
  def index
    shop_id = params[:id]
    area_node_id = params[:area_node_id]

    @shop = Shop.find_by(id: shop_id)

    resource_service_factory = ResourceServiceFactory.new
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    user_item_factory = UserItemFactory.new(equipped_list_service_factory)

    # player
    @player_character = player_character_factory.build_by_user_id(current_user.id)
    if @player_character.nil?
      redirect_to('/player/input')
      return
    end

    @showcases = []
    @shop.showcases.each do |showcase|
      @showcases.push(Shop::ShowcaseService.new(resource_service_factory.build_by_target_id_and_resource(area_node_id, showcase.resource), area_node_id, showcase))
    end

    @user_items = user_item_factory.build_unequipped_user_item_list_by_player_id(@player_character.id)
  end

  # 購入する
  def buy
    shop_id = params[:shop_id]
    area_node_id = params[:area_node_id]
    resource_id = params[:resource_id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    # TODO: validateクラスに寄せる
    area_node = AreaNode.find_by(id: area_node_id)
    @shop      = Shop.find_by(id: shop_id)
    resource  = Resource.find_by(id: resource_id)

    if area_node.nil? || resource.nil? || @shop.nil?
      redirect_to('/')
      return
    end

    player_character = player_character_factory.build_by_user_id(current_user.id)

    redirect_to('/player/input') if player_character.nil?

    resource_service_factory = ResourceServiceFactory.new
    resource_service = resource_service_factory.build_by_target_id_and_resource(area_node_id, resource)

    item_service_factory = ItemServiceFactory.new(player_character)
    item_service = item_service_factory.build_by_item_id(resource_service.item.id, 1)

    fail 'shop is nil' if @shop.nil?
    fail 'resource is nil' if resource.nil?

    showcase = Showcase.find_by(shop_id: @shop.id, resource_id: resource.id)

    resource_purchase_service = ResourceAction::ResourcePurchaseService.new(resource_service, item_service, player_character.player, showcase)

    @result = resource_purchase_service.execute
    redirect_to('/') unless @result[:success]

    @showcases = []
    @shop.showcases.each do |s|
      @showcases.push(Shop::ShowcaseService.new(resource_service_factory.build_by_target_id_and_resource(area_node_id, s.resource), area_node_id, s))
    end
  end
end

