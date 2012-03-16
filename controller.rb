require 'rubygems'
require 'sinatra'
require 'pdbm.rb'
require 'dm-validations'

before do
headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do

erb :login
end

get '/check' do

@users=User.all
@users.each do |u|
if  u.login == params[:login]
	@user = User.get(u.id)
end
end
if @user && params[:password] == @user.password
erb :user_reports
elsif params[:login] == 'newcomer' && params[:password] == 'password'
erb :uform
elsif params[:login] == 'admin' && params[:password] == 'admin'
erb :admin
else
@message ="Please enter correct login and password!!"
erb :login	
end
end


get '/Record' do
@title="Record creation"
@projects=Project.all
erb :reform
end

get '/User' do
@title="User creation"
@a = @message
erb :uform
end

get '/Project' do
@title="Project creation"

erb :pform
end

get '/catch/project' do

@pr = Project.get(params[:id_p])

erb :user_reports
end

get '/User/:id' do
@user = User.get(:id)	
erb :rform
end

post '/create/Project' do
@project = Project.new(params[:Project])
if @project.save
@title="Project <%=@project.title%>"
erb :pshow
else
redirect '/Project'
end
end

post '/create/Record/:id' do

project = Project.get(params[:id])

@record = project.records.create(
:reporting_time => params[:reporting_time],
:description => params[:description],
:spent_time => params[:spent_time]
)


#if @record.spent_time.valid?
#@record.save
erb :show
#else
#@projects=Project.all
#@false = @record
#@message = "Your time format is invalid, please enter time in valid format HH:MM"
#erb :rform
#end
end

post '/create/User' do
@user=User.new(params[:User])
if @user.save
	redirect "/User/#{@user.id}"
	else
  @message = "Something went wrong. Please try again!"
  redirect '/User' 
end
end
