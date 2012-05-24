class FileDatabase

  def save
    # read all files in database
    # create an object per file (=player)
    # populate with activities
  end
  
  def load(players)
    # create a file per player
    players.each do |player|
      player_file = File.open(player)
      # in this file : one activity per line, each attribute separated by a space 
      player.activities.each do |activity|
        activity_string = activity.type + " " + activity.time + " " +activity.cal + " "+ activity.km + "\n"
        player_file.write(activity_string)
      end
      player_file.close
    end

  end

end
