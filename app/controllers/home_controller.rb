class HomeController < ApplicationController
  layout "main"
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def map
    
  end

  def social
  end

  def howto
  end

  def about
  end

end
