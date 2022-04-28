class CommentsController < ApplicationController
    def create
        @post= Post.find_by(id: params[:id])
        @comment = Comment.new(content: params[:content],
                                user_id: @current_user.id,
                                post_id: params[:post_id])
        if @comment.save
            redirect_to request.referer
        else
            redirect_to request.referer
        end
    end
    
     
end
