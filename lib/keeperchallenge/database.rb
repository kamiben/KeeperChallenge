DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/keeperchallenge.db")

class User
  include DataMapper::Resource
  
  has n, :activities
  has n, :challenges
  
  property :id, Serial
  property :name, Text, :required => true
  property :score , Integer, :default => 0
  property :created_at, DateTime
  
  
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

class Activity
  include DataMapper::Resource
  
  belongs_to :user
  
  property :id, Serial
  property :type, Text
  property :time, Integer
  property :cal, Integer
  property :km, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Challenge
  include DataMapper::Resource
  
  belongs_to :user
  has n, :users
  
  property :id, Serial
  property :name, Text
  property :started_at, DateTime
  property :ended_at, DateTime

end

DataMapper.finalize.auto_upgrade!


class FileDatabase
  attr_reader :folder_path
  # will create the db folder if not present on system
  def initialize
    #if db folder does not exist, create it
    @folder_path = File.dirname(__FILE__) + "/db/"
    puts @folder_path
    unless File.directory?(@folder_path)
      Dir.mkdir(@folder_path)
    end
  end

  
  #will load all files from db directory and load them as player and activities
  def load(players)

    # read all files in database
    
    Dir.foreach(@folder_path) do |file|
      if !(file =='.' || file == '..')
        # create an object per file (=player)
        players.update({file => Player.new(file)})
        # populate with activities
        content = File.open("#{@folder_path}#{file}")
        content.each_line do |line|
          activity = line.split(' ')
          players[file].add_activity(activity[0], activity[1], activity[2], activity[3])
        end

        content.close
      end
    end
  end
  
  #will save player to static files in db directory
  def save(players)
    # create a file per player
    players.each do |key,player|
      file_name = "#{@folder_path}#{player.name}"
      player_file = File.open(file_name,'w')
      # in this file : one activity per line, each attribute separated by a space 
      player.activities.each do |activity|
        activity_string = "#{activity.type} #{activity.time} #{activity.cal} #{activity.km}\n"
        player_file.write(activity_string)
      end
      player_file.close
    end

  end
  
  #Will remove all player files from the db directory
  def clear
    Dir.foreach(@folder_path) do |file|
      unless (file =='.' || file == '..')
        File.delete("#{@folder_path}#{file}")
      end
    end
  end

end

