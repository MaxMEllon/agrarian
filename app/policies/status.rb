class Status
  attr_reader :attack, :defense
  def initialize(attack, defense)
    @attack = attack
    @defense = defense
  end

  def +(other)
    new_attack = attack + other.attack
    new_defense = defense + other.defense
    return Status.new(new_attack, new_defense)
  end
end

