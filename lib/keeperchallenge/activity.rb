class Activity
  attr_reader :type,:time,:cal,:km
  
  def initialize(type, time, cal, km)
    @type = type
    @time = time
    @cal = cal
    @km = km
  end
end