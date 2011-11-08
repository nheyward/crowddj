class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @title = "Profile"
    @user = User.find(params[:id])
    @venues = @user.venues
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = "Sign-In or Register"
    @user = User.new

  end

  # GET /users/1/edit
  def edit
    # @user = User.find(params[:id]) - Now defined in authentucate function
    @title = "Edit Profile"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #  @user = User.find(params[:id]) - Now defined in authenticate function
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        @title = "Edit Profile"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @usertogo = User.find(params[:id])
    @usertogo.destroy
  
    respond_to do |format|
      flash[:success] = "User destroyed."
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  private
  
  def authenticate
    @user = User.find(params[:id])
    if current_user != @user
      flash[:notice] = "Please sign-in as the right user to edit details"
      deny_access
    end
  end
  
   def admin_user
      redirect_to(root_path) unless current_user.admin?
   end
    
end
