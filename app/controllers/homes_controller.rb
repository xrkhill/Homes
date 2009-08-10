
# TODO
# add ratings (1-5)
# add minutes travel for mel and rich
# x make all bool fields checkboxes
# x add viewed/seen field
# x change order of short sale vs address fields
# x add active field
# x add still interested field? hide if not looking anymore

class HomesController < ApplicationController
  # GET /homes
  # GET /homes.xml
  def index
    # filter
    if params[:show]
      conditions = "AND #{params[:show]} = 't'"
    end

    # order by column
    if params[:order]
      @order = params[:order]
    else
      @order = "created_at"
    end

    # sorting direction; desc by default
    if params[:direction] && params[:direction] == 'desc'
      @direction_current = 'desc'
      @direction_new = 'asc'
    else
      @direction_current = 'asc'
      @direction_new = 'desc'
    end

    @homes = Home.all(:conditions => "active = 't' AND interested = 't' #{conditions}", :order => @order + ' ' + @direction_new)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @homes }
    end
  end

  # GET /homes/1
  # GET /homes/1.xml
  def show
    if params[:id].to_i > 800000
      @home = Home.find_by_mls_number(params[:id])
    else
      @home = Home.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/new
  # GET /homes/new/654321
  # GET /homes/new.xml
  # GET /homes/new/654321.xml
  def new
    @home = Home.new

    # don't show photo if there is no MLS#
    @show_photo = false

    if params[:mls_number] != nil && params[:mls_number].empty? != true
      @home.mls_number = params[:mls_number].strip
      @show_photo = true

      # pull info from MLS
      res = Net::HTTP.get_response(URI.parse("http://www.utahhomes.com/#{params[:mls_number].strip}"))

      # search HTML for relevant fields
      @home.price = res.body.scan(/<input name="hdnPrice" type="hidden" id="hdnPrice" size="1" value="(\d+)" \/>/)
      @home.square_feet = res.body.scan(/<strong>Approx. Square Feet:<\/strong> (\d+)<br>/)

      scan_address = res.body.scan(/<span id=\"(lblAddress|lblCityStateZip)\">(.+)<\/span>/)
      @home.address = scan_address[0][1] + scan_address[1][1]

      # set home as active by default
      @home.short_sale = false
      @home.favorite = false
      @home.active = true
      @home.interested = true
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.xml
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        flash[:notice] = 'Home was successfully created.'
        format.html { redirect_to(@home) }
        format.xml  { render :xml => @home, :status => :created, :location => @home }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /homes/not_interested/1
  # PUT /homes/not_interested/1.xml
  def not_interested
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attribute(:interested, false)
        flash[:notice] = 'Home was successfully marked as not interested.'
        format.html { redirect_to(homes_url) }
        format.xml  { head :ok }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.xml
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        flash[:notice] = 'Home was successfully updated.'
        format.html { redirect_to(@home) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.xml
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to(homes_url) }
      format.xml  { head :ok }
    end
  end
end
