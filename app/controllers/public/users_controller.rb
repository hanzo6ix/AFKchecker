class Public::UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  #フレンド一覧画面
  def friends
    @mates = current_user.matchers
    @users = User.all
    #@request = current_user.follow_request?
    @user = User.find(params[:user_id])
    #@user = user.followers
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: 'ユーザー情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
