class VenuesController < ApplicationController
  before_filter :check_signed_in, :only => [:new, :create, :destroy]
  
  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    @venue = Venue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new(:user_id => current_user.id )
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        format.html { redirect_to(@venue, :notice => 'Venue was successfully created.') }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to(@venue, :notice => 'Venue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
     venue = Venue.find(params[:id])
     venue.destroy
    flash[:success] = "Venue deleted"
    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  private
  
  def check_signed_in
    if current_user == nil
      flash[:notice] = "Log in to add a venue"
      redirect_to log_in_path
    end 
  end
  
end
