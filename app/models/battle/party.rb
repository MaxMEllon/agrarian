class Battle::Party
  attr_reader :name
  def initialize(unit_list, name)
    @unit_list = unit_list
    @name      = name
  end

  # パーティが全滅しているかどうかを返す。
  def is_dead
    @unit_list.each do |unit|
      #一人でも死んでなかったらfalse
      if(unit.is_dead == false)
        return false
      end
    end

    return true
  end

  # まだ行動してなくて、死んでないユニットを取得する。
  # TODO: 素早さとかでソートする？
  def get_actionable_unit
    @unit_list.each do |unit|
      if(!unit.is_dead && !unit.done_action)
        return unit
      end
    end

    return nil
  end

  # 攻撃対象を取得する。
  def get_attackable_unit
    @unit_list.each do |unit|
      if(!unit.is_dead)
        return unit
      end
    end
  end

  # パーティを全員行動させる
  # TODO:unit = character
  def do_action(party)
    action_list = Array.new()

    unit = self.get_actionable_unit
    while(unit != nil)
      action_list.push(unit.get_action(party))
      unit.done_action = true
      unit = self.get_actionable_unit
    end

    return action_list
  end

  # 行動済みfalseにする。
  def reset_done_action()
    @unit_list.each do |unit|
      unit.done_action = false
    end
  end

  # パーティ全員の状態を取得する。
  def current_state_list()
    state_list = Array.new
    @unit_list.each do |unit|
      state_list.push(unit.get_current_state)
    end

    return state_list
  end
end