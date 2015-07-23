class QuestController < ApplicationController
  def index
    # なにはともあれ
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if @player_character.nil?
      redirect_to '/player/input'
      return
    end

    @user_quests = UserQuest.where(player_id: @player_character.id).select{|user_quest| !user_quest.is_not_received}
  end
end