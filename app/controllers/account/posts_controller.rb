class Account::PostsController < ApplicationController
  before_action :authenticate_user!

def index
  @posts = current_user.posts.recent.paginate(:page => params[:page], :per_page => 5)
end

def edit
  @posts = Post.find(params[:id])
end

def update
  @posts = Post.find(params[:id])
  if @posts.update(posts_params)
   redirect_to account_posts_path, notice: "Update Success"
 else
   render :edit
 end
end

 def destroy
   @posts = Post.find(params[:id])
   if current_user != @posts.user
     redirect_to account_posts_path, alert: "You have no permission."
   end
   @posts.destroy
   flash[:alert] = "Post deleted"
   redirect_to account_posts_path
 end

 private
 def posts_params
   params.require(:post).permit(:content)
 end

end
