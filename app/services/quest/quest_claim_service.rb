# Questの報酬を与えるサービス
class Quest::QuestClaimService
  def initialize(quest_entity, item_service)
    @quest_entity = quest_entity
    @item_service = item_service
  end

  def claim
    begin
      ActiveRecord::Base.transaction do
        # questを報酬受け取り済みにする。
        if !@quest_entity.set_claimed
          fail 'cant claim if not cleared'
        end

        # アイテムを与える。
        @item_service.give

        @quest_entity.save!
        @item_service.save!
      end
    rescue => e
      fail e
    end
  end
end

