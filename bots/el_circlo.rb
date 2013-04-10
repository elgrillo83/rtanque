class ElCirclo < RTanque::Bot::Brain
  NAME = 'ElCirclo'
  include RTanque::Bot::BrainHelper

  def tick!
    do_the_circle

    if (target = nearest_target)
      fire_upon(target)
    else
      detect_targets
    end
  end

  def do_the_circle
    command.speed = MAX_BOT_SPEED
    command.heading = sensors.heading + RTanque::Heading::ONE_DEGREE * 2
  end

  def nearest_target
    sensors.radar.min { |a, b| a.distance <=> b.distance }
  end

  def fire_upon(target)
    command.radar_heading = target.heading
    command.turret_heading = target.heading
    command.fire(MAX_FIRE_POWER)
  end

  def detect_targets
    command.radar_heading = sensors.radar_heading + MAX_RADAR_ROTATION
    command.turret_heading = sensors.heading + RTanque::Heading::HALF_ANGLE
  end

end
