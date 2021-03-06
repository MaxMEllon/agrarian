# 装備奴
class EquipmentService
  attr_reader :status
  def initialize(user_item, equipment)
    @user_item = user_item
    @equipment = equipment
    @status    = Status.new(equipment.attack, equipment.defense)
  end

  def name
    return @user_item.item.name
  end

  def attack
    return @equipment.attack
  end

  def defense
    return @equipment.defense
  end

  def user_item_id
    return @user_item.id
  end
end

