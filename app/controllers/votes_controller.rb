post '/:obj_type/:obj_id/votes' do |parent_type, parent_id|
  parent_obj = (parent_type == "questions") ? Question.find_by(id: parent_id) : Answer.find_by(id: parent_id)
  if session[:user_id]
    if parent_obj
      vote = Vote.where(user_id: session[:user_id], voteable: parent_obj).first_or_initialize
      vote.value = -1 if params[:down_vote] #change the default value away from 1
      vote.save
    else
      flash[:message] = "couldnt not find the object you wanted to vote on"
      redirect '/'
    end
  else
    flash[:message] = "must be signed in to vote"
    redirect '/'
  end
  redirect "/#{parent_type}/#{parent_id}"
end

