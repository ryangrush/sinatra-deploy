class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  post '/users' do
    User.find_or_create_by!(
      first_name: params[:first_name],
      last_name: params[:last_name]
    )

    redirect '/users'
  end

end
