class EnemyCharacter
  def initialize(enemy, progress)
    @enemy = enemy
    @hp = StatusPoint.new(@enemy.hp, @enemy.hp)
    @progress = progress
  end

  def name
    return @enemy.name
  end

  def attack
    return @enemy.attack
  end

  def defense
    return @enemy.defense
  end

  def hp
    @hp.current
  end

  def hp_max
    return @hp.max
  end

  def decrease_hp(value)
    @hp.decrease(value)
    if @hp.current <= 0
      @progress.count += 1
    end
  end

  def rails
    return @enemy.rails
  end

  def save
    @progress.save
  end
end

