class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @title = "All users"
    @users = User.all
    #@users = User.paginate(:page => params[:page])
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
    
  def new
    @user = User.new
    @title = "Sign In"   
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:succsess]="Welcome :)"
      redirect_to @user
    else
      @title = "Sign In"
      render 'new'
    end
  end 
  
  def edit
    @title = "Edit profile"
  end   
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit profile"
      render 'edit'
    end
  end
  
  private

    #def authenticate
      #deny_access unless signed_in?
    #end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end    
  
end
