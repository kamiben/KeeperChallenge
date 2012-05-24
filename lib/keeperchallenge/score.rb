class Score 

  def initialize(players)
    @players = players
  end
  
  def compute(activities_type)
    #reset to prevent abuse from calling the scoreboard multiple times
    reset_player_scores()
    
    # Parcours de toutes les activités pour déterminer le meilleur dans chaque
    activities_type.each do |activity| 
      #parcours chaque joueur et détermine leur score dans l'activité
      total_time = {}
      total_cal = {}
      total_km = {}
      @players.each do |player|
        total_time[player.name] =0
        total_cal[player.name] =0
        total_km[player.name] =0   
        
        player.list_by_type(activity).each do |player_activity|
          total_time[player.name]  += player_activity.time.to_i
          total_cal[player.name]  += player_activity.cal.to_i
          total_km[player.name]  += player_activity.km.to_i
        end
      end
      
      #détermine le meilleur de chaque discipline
      @players.each do |player|
        if player.name == find_best_score(total_time)
          puts "Best total time in #{activity} for #{player.name}, adding 3 points"
          player.score += 3
        end
        if player.name == find_best_score(total_cal)
          puts "Best total cal in #{activity} for #{player.name}, adding 3 points"
          player.score += 3
        end
        if player.name == find_best_score(total_km)
          puts "Best total km in #{activity} for #{player.name}, adding 3 points"
          player.score += 3
        end        

      end
      
    end
    
    #Incrémentation du compteur pour le nombre d'activités différentes effectuées
    @players.each do |player|
      puts "Adding numbers of activity = #{player.count_activity_type}"
      player.score += player.count_activity_type
    end
    
  end
  
  def find_best_score(total_per_player)
    best_score = 0
    winner = ''
    total_per_player.each do |player_name,total|

      if total > best_score
        best_score = total
        winner = player_name
      end
    end
    return winner
  end
  
  
  def reset_player_scores()
    @players.each do |player|
      player.score = 0
    end
  end
  
end