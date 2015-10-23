# # post '/:obj_type/:obj_id/votes' do |parent_type, parent_id|
# # end

# class VotesController < ApplicationController

#   def create
#     parent_obj = (params[:obj_type] == "questions") ? Question.find_by(id: params[:obj_id]) : Answer.find_by(id: params[:obj_id])
#     if session[:user_id]
#       if parent_obj
#         vote = Vote.where(user_id: session[:user_id], voteable: parent_obj).first_or_initialize
#         vote.value = -1 if params[:down_vote] #change the default value away from 1
#         vote.save
#       else
#         flash[:message] = "couldnt not find the object you wanted to vote on"
#         redirect_to root_path and return
#       end
#     else
#       flash[:message] = "must be signed in to vote"
#       redirect_to root_path and return
#     end
#     redirect "/#{parent_type}/#{parent_id}"
#   end

# end

# upvotes:
# nil: create vote record with 1
# 1: do nothing
# 0: update to 1
# -1: update to 0

# downvotes:
# nil: create vote record with -1
# -1:


# 2 routes, one for each voteable object.
# 2 vote methods in each voteable controller
# 1 vote model method which checks for those three things above(the change mind) method
# those vote controller methods then create, update or ignore and redirect

