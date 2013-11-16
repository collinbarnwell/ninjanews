class SourcesController < ApplicationController
  def new
    if current_user.is_admin
      @source = Source.new(source_params)
      @feeds = Feed.all
    end
  end

  def create
    if current_user.is_admin
      @source = Source.new(params[:source])
      if @source.save
        redirect_to :back, notice: "Source (#{@source.name} created."
      else
        render action: 'new'
      end
    end
  end

  def edit
    if current_user.is_admin
      @source = Source.find(params[:source])
    end
  end

  def update
    if current_user.is_admin
      @source = Source.find(params[:id])
      if @source.update_attributes(source_params)
        redirect_to :back, notice: 'Source updated.'
      else
        render action: 'new'
      end
    end
  end

  def destroy
    if current_user.is_admin
      Source.find(params[:source]).destroy
    end
  end

  private

    def source_params
      params.permit(:title, :url, :area)
    end
end
