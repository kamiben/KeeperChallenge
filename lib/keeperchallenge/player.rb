class Player
  attr_reader :name
  attr_accessor :activities, :score
  
  def initialize(name)
    @name = name
    @activities = []
    @score = 0
  end
  
  def add_activity(type, time, cal, km)
    new_activity = Activity.new(type, time, cal, km)
    @activities.push(new_activity)
  end
  
  def list_by_type(type)
    activity_by_type = []
    @activities.each do |activity|
      if activity.type == type
        activity_by_type.push(activity)
      end
    end
    return activity_by_type
  end
  
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