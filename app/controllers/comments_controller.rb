class CommentsController < ApplicationController
	def create
		@comment = Comment.new(params.require(:comment).permit( :post_id, :body))
		@comment.user_id = session[:user_id]
		if @comment.save
			flash[:notice] = "Your comment has been saved!"
		else
			flash[:alert] = "You comment was not saved, please try again!"
		end
		redirect_to :back
	end
end
