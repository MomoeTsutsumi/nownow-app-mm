class RanksController < ApplicationController
  def rank
    post_like_count = {}
    User.all.each do |user|
      post_like_count.store(user, Like.where(post_id: Post.where(user_id: user.id).limit(7).pluck(:id)).count)
    end
    @user_post_like_ranks = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    

    @user_post_ranks = User.where(id: Post.group(:user_id).order('count(user_id)').limit(7).pluck(:user_id))
  
  end
  
end
