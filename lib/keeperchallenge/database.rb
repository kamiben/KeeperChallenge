DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/keeperchallenge.db")

class Player
  include DataMapper::Resource
  
  #
  #has n, :challenges
  
  property :name, Text, :key => true, :unique_index => true
  property :score , Integer, :default => 0
  property :created_at, DateTime
  
  has n, :activities
  has n, :challenges

  # Will count all sports the player practised.
  def count_activity_type()
    total_activities_type = 0
    previous_activity = ''
    self.activities.all.each do |activity|
      if activity != previous_activity
        activity = previous_activity
        total_activities_type += 1
      end
    end
    return total_activities_type
  end
  
end

class Activity
  include DataMapper::Resource

  property :id, Serial
  property :activitytype, Text
  property :time, Integer
  property :cal, Integer
  property :km, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :player

end

class Challenge
  include DataMapper::Resource
  
  property :id, Serial
  property :name, Text
  property :started_at, DateTime
  property :ended_at, DateTime

  belongs_to :player
end

#destructive migration. (to keep data, use upgrade)
DataMapper.finalize.auto_upgrade!