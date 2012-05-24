class FileDatabase

  def load(players)
    index = 0
    # read all files in database
    Dir.foreach("../db/") do |file|
      if !(file =='.' || file == '..')
        # create an object per file (=player)
        players.push(Player.new(file))
        # populate with activities
        content = File.open("../db/#{file}")
        content.each_line do |line|
          activity = line.split(' ')
          players[index].add_activity(activity[0], activity[1], activity[2], activity[3])
        end
        index += 1
      end
    end
  end
  
  def save(players)
    # create a file per player
    players.each do |player|
      file_name = "../db/#{player.name}"
      player_file = File.open(file_name,'w')
      # in this file : one activity per line, each attribute separated by a space 
      player.activities.each do |activity|
        activity_string = "#{activity.type} #{activity.time} #{activity.cal} #{activity.km}\n"
        player_file.write(activity_string)
      end
      player_file.close
    end

  end

end
