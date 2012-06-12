if development? 
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/keeperchallenge.db")
end

DataMapper::Logger.new(STDOUT, :debug)

class Player
  include DataMapper::Resource
  
  #
  #has n, :challenges
  
  property :name, Text, :key => true, :index => true, :unique_index => true, :length => 10
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
  property :time, Integer
  property :cal, Integer
  property :km, Float
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :player
  belongs_to :activitytype

end

class Activitytype
  include DataMapper::Resource

  property :id, Serial
  property :name, Text

  has n, :activities
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