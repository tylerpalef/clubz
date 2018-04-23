class ClubsController < ApplicationController
  before_action :ensure_login, except: [:index]
  before_action :ensure_role, except: [:index]
  before_action :ensure_ownership, only: [:edit, :update]

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])

    # if current_user
    #   @club = Club.find(params[:id])
    #   render :show
    # else
    #   redirect_to new_sessions_path
    # end
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(
      name: params[:club][:name],
      description: params[:club][:description],
      user: current_user
    )

    if @club.save
      redirect_to root_path
    else
      flash.now[:alert] = @club.errors.full_messages
      render :new
    end
  end

  def edit
    # @club = Club.find(params[:id])
  end

  def update
    # @club = Club.find(params[:id])

    if @club && @club.update(name: params[:club][:name], description: params[:club][:description], user: current_user)
      redirect_to root_path
    else
      flash.now[:alert] = @club.errors.full_messages
      render :edit
    end
  end

  private

  def ensure_login
    redirect_to new_sessions_path if !current_user
  end

  def ensure_ownership
    @club = Club.find(params[:id])
    redirect_to root_path if current_user.id != @club.user_id
    # redirect_to root_path unless current_user.id == @club.user_id
  end

  def ensure_role
    # unless current_user.role == "wizard" || current_user.role == "hobbit"
    unless Club.allowed_roles.include?(current_user.role)
      redirect_to root_path
    end
  end

end
