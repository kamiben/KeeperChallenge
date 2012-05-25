class Player
  attr_reader :name
  attr_accessor :activities, :score
  
  #only need a name to initialize a player
  def initialize(name)
    @name = name
    @activities = []
    @score = 0
  end
  
  # to add an activity, need all the parameters of an activity
  def add_activity(type, time, cal, km)
    new_activity = Activity.new(type, time, cal, km)
    @activities.push(new_activity)
  end
  
  # will return all activities taken for a type of activity in an array
  def activities_taken(type)
    activity_by_type = []
    @activities.each do |activity|
      if activity.type == type
        activity_by_type.push(activity)
      end
    end
    return activity_by_type
  end
  
  # Will count all sports the player practised.
  def count_activity_type
    total_activities_type = 0
    previous_activity = ''
    
    @activities.each do |activity|
      if activity != previous_activity
        activity = previous_activity
        total_activities_type += 1
      end
    end
    return total_activities_type
  end
  
end