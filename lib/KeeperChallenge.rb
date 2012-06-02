require 'sinatra'
require 'dm-core'
require 'dm-migrations'

require File.dirname(__FILE__) +'/keeperchallenge/score'
require File.dirname(__FILE__) +'/keeperchallenge/database'
require File.dirname(__FILE__) +'/keeperchallenge/dbsetting'

# Main program
class Main
  def setup_test_users
    @players.update({"Ben" => Player.new("Ben")})
    @players.update({"Claire" => Player.new("Claire")})
    
    @players["Ben"].add_activity("velo", 15, 15, 15)
    @players["Ben"].add_activity("course", 10, 10, 10)
    @players["Claire"].add_activity("course", 20, 20, 20)
    @players["Claire"].add_activity("velo", 12, 12, 12)
    @players["Claire"].add_activity("natation", 30, 20, 10)
  end  
end



  get '/' do
    erb :index,:locals => {:message => ''}
  end

  get '/add-activity' do 
    @activities_type = ["velo", "course" , "marche",  "natation"]
    @players = Player.all
    erb :addactivity_form
  end

  post '/add-activity' do 

    # we need to add an activity
    player = Player.get!(params[:name])
    new_activity = player.activities.new
    new_activity.activitytype = params[:activitytype]
    new_activity.time = params[:time]
    new_activity.cal = params[:cal]
    new_activity.km = params[:km]
    new_activity.created_at = Time.now
    new_activity.updated_at = Time.now
    
    new_activity.save
    message = "Activity successfully added, ID #{new_activity.id} Player #{new_activity.player.name} Type #{new_activity.activitytype} Time : #{new_activity.time}"
    erb :index,:locals => {:message => message}
  end

  get '/add-player' do 
    erb :addplayer_form
  end
  
  post '/add-player' do

    new_user = Player.new
    new_user.name = params[:name]
    new_user.created_at = Time.now
    new_user.save
    message = "Player successfully added, Name : #{new_user.name} Creation date : #{new_user.created_at}."
    #puts User.get(:id => 1).name
    erb :index,:locals => {:message => message}
  end

  get '/player/:id' do
    @player = Player.get(params[:id])
    @activities = @player.activities.all
    erb :edit_player

  end
  
  get '/player' do
    @player = Player.all
    erb :show_players

  end
  
  get '/activity/:id' do
    @activities_type = ["velo", "course" , "marche",  "natation"]
    @activity = Activity.get(params[:id])
    erb :edit_activity
  end
  
  post '/activity/:id' do 

    # we need to edit an activity
    
    edit_activity = Activity.get(params[:id])
    edit_activity.activitytype = params[:activitytype]
    edit_activity.time = params[:time]
    edit_activity.cal = params[:cal]
    edit_activity.km = params[:km]
    edit_activity.updated_at = Time.now 
    edit_activity.save
    message = "Activity successfully edited, ID #{edit_activity.id} Player #{edit_activity.player.name} Type #{edit_activity.activitytype} Time : #{edit_activity.time}"
    erb :index,:locals => {:message => message}
  end
  
  get '/activity/:id/delete' do
    @activity = Activity.get(params[:id])
    erb :delete_activity
  end
  
  delete '/activity/:id' do
    a = Activity.get params[:id]
    a.destroy
    redirect '/'
  end
  
  
  get '/scoreboard' do
    @activities_type = ["velo", "course" , "marche",  "natation"]
    @players = Player.all
    score = Score.new(@players)
    score.compute(@activities_type)
    erb :display_scores, :locals => {:players => @players}
  end


