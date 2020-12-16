
require './db.rb'
require './Access.rb'

require 'sinatra'
 
 access_log = []	

get '/' do 

erb :login

end

post '/' do

	if params['send'] = 'send'
	
	access_log.append(Access.new(params['user'],params['password'],'U'))
	outcome = access_log.last.grant_access
	outcome == "access granted" ? redirect('/in') : redirect('/out')
 		
	end
end 

get '/out' do

erb :out 

end

get '/in' do

	erb :in 

end 

post '/in' do 

	if params["button_value"] == "add_file" 
		redirect('/in_file')
	end 
	
	if params["button_value"] == "my_files" 
		redirect( '/my_files')
	end 

end 

get '/in_file' do

	"In files"

end 

get '/my_files' do 

	"my files"

end 
	
	
	