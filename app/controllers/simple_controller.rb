class SimpleController < ApplicationController
  def index

    respond_to do |format|
      format.html
    end
  end
  
  def vime_template
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end
