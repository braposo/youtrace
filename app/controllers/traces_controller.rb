class TracesController < ApplicationController
  # GET /traces
  # GET /traces.xml
  def index
    @traces = Trace.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traces }
    end
  end

  # GET /traces/1
  # GET /traces/1.xml
  def show
    @trace = Trace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trace }
    end
  end

  # GET /traces/new
  # GET /traces/new.xml
  def new
    @trace = Trace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trace }
    end
  end

  # GET /traces/1/edit
  def edit
    @trace = Trace.find(params[:id])
  end

  # POST /traces
  # POST /traces.xml
  def create
    @trace = Trace.new(params[:trace])

    respond_to do |format|
      if @trace.save
        flash[:notice] = 'Trace was successfully created.'
        format.html { redirect_to(@trace) }
        format.xml  { render :xml => @trace, :status => :created, :location => @trace }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /traces/1
  # PUT /traces/1.xml
  def update
    @trace = Trace.find(params[:id])

    respond_to do |format|
      if @trace.update_attributes(params[:trace])
        flash[:notice] = 'Trace was successfully updated.'
        format.html { redirect_to(@trace) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /traces/1
  # DELETE /traces/1.xml
  def destroy
    @trace = Trace.find(params[:id])
    @trace.destroy

    respond_to do |format|
      format.html { redirect_to(traces_url) }
      format.xml  { head :ok }
    end
  end
end
