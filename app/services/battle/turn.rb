class Battle::Turn
  def initialize(party_a, party_b)
    @party_a = party_a
    @party_b = party_b
    @current_turn = 0
  end

  # ターンを経過させる。
  def do_battle()
    #TODO: 誰が最初に行動するとか
    action_list = Array.new()

    # TODO: party_aがまず全員行動することにしとく
    a_action_list = @party_a.do_action(@party_b)
    b_action_list = @party_b.do_action(@party_a)

    action_list.concat(a_action_list)
    action_list.concat(b_action_list)

    # どちらかのパーティが全滅したらバトル終了
    is_battle_end = @party_a.is_dead || @party_b.is_dead
    @current_turn += 1
    if(!is_battle_end)
      @party_a.reset_done_action
      @party_b.reset_done_action
    end

    return Battle::TurnResult.new(
      action_list, 
      @current_turn, 
      is_battle_end,
      @party_a,
      @party_b)
  end
end

class Battle::TurnResult
  attr_reader :action_list, :is_battle_end, :turn_count, :result_list
  def initialize(
    action_list, 
    turn_count, 
    is_battle_end,
    party_a,
    party_b)

    @action_list = action_list
    @is_battle_end = is_battle_end
    @turn_count  = turn_count
    @party_a     = party_a
    @party_b     = party_b
    @result_list = self.create_result_list
  end

  def create_result_list
    result_list = Array.new
    if(@is_battle_end)
      if(@party_a.is_dead)
        result_list.push(@party_a.name + "は全滅した。")
        result_list.push(@party_b.name + "の勝利")
      else
        result_list.push(@party_b.name + "は全滅した。")
        result_list.push(@party_a.name + "の勝利")
      end
    else
      result_list.push("[" + @party_a.name + "の状態" + "]")
      result_list.concat(@party_a.current_state_list)
      result_list.push("[" + @party_b.name + "の状態" + "]")
      result_list.concat(@party_b.current_state_list)
    end
    return result_list
  end
end