require './keeperchallenge/player'
require './keeperchallenge/score'
require './keeperchallenge/activity'
require './keeperchallenge/database'
#TODO
#import activity and players from text file ?


# will handle user input - will to quit the program, input from the console
class UserInput
  attr_accessor :exit
  def initialize
    exit = false
  end
  
  def get_input
    print '> '
    result = gets.chomp()
    return result
  end
  
end

#will handle display to the screen , main menu, sub menus ...
class Display
  def initialize(input)
    @input = input
  end
  #Hello
  def hello
    puts "Welcome to KeeperChallenge!\n"
  end
  #menu
  def menu
    puts "Please select your action"
    puts "1. Add activity"
    puts "2. Add player"
    puts "3. Display scoreboard"
    puts "4. Exit"
    choice = @input.get_input
    case choice.to_i
      when 1 then return :add_activity
      when 2 then return :add_player
      when 3 then return :launch_scoreboard
      when 4 then @input.exit = true
    end
  end

  def select_player(players)
    puts "Please select your player"
    i=1
    if !players.empty?
      players.each do |player|
        puts "#{i}. #{player.name}"
      end
      choice = @input.get_input
      return choice.to_i-1
    else
      puts "There are no players in the database"
      return nil
    end
  end
  
  def add_player
    puts "Enter the new player name :"
    name = @input.get_input
    return name
  end
  
  def add_activity(activities_type)
    
    puts "Enter activity type"
    puts "possible activities : "
    puts activities_type
    type = @input.get_input
    while !activities_type.include?(type)
      puts "activity invalid"
      type = @input.get_input
    end
    puts "Enter time"
    time =  @input.get_input
    puts "Enter cal"
    cal =  @input.get_input
    puts "Enter Km"
    km = @input.get_input
    return type, time, cal, km
  end
  
  def display_scores(players)
    puts "Scores :"
    players.each do |player|
      puts "#{player.name} : #{player.score}"
    end
  end
  
end


# Main program
class Main

  def initialize
    # load players
    # load activities
    @players = []
    @activities_type = ["velo", "course" , "marche",  "natation"]
   #setup_test_users

  end
  def launch
    input = UserInput.new()
    screen = Display.new(input)
    db = FileDatabase.new()
    db.load(@players)
    screen.hello
    while !input.exit
      action = screen.menu
      case action 
        when :add_activity then 
          player = screen.select_player(@players)
          if !player.nil?
            type, time, cal, km = screen.add_activity(@activities_type)
            @players[player].add_activity(type, time, cal, km)
          end
        when :add_player then 
          name = screen.add_player
          new_player = Player.new(name)
          @players.push(new_player)
          #add player
        when :launch_scoreboard then 
          score = Score.new(@players)
          score.compute(@activities_type)
          screen.display_scores(@players)
      end
      db.save(@players)
    end
  end
  
  def setup_test_users
    @players.push(Player.new("Ben"))
    @players.push(Player.new("Claire"))
    
    @players[0].add_activity("velo", 15, 15, 15)
    @players[0].add_activity("course", 10, 10, 10)
    @players[0].add_activity("course", 20, 20, 20)
    @players[1].add_activity("velo", 12, 12, 12)
    @players[1].add_activity("natation", 30, 20, 10)
  end

  
end

challenge = Main.new()
challenge.launch