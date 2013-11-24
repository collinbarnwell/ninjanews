class SourcesController < ApplicationController
  def new
    if current_user.is_admin
      @source = Source.new
      @feeds = Feed.all
    end
  end

  def create
    if current_user.is_admin
      @source = Source.new(source_params)
      if @source.save
        redirect_to :back, notice: "Source (#{@source.title} created."
      else
        render action: 'new'
      end
    end
  end

  def edit
    if current_user.is_admin
      @source = Source.find(params[:id])
    end
  end

  def update
    if current_user.is_admin
      @source = Source.find(source_params)
      if @source.update_attributes(source_params)
        redirect_to :back, notice: 'Source updated.'
      else
        render action: 'new'
      end
    end
  end

  def index
    if current_user.is_admin
      @sources = Source.all
    end
  end

  def destroy
    if current_user.is_admin
      Source.find(params[:id]).destroy
      redirect_to sources_path, notice: 'Source destroyed.'
    end
  end

  private

    def source_params
      params.require(:source).permit(:title, :url, :area)
    end
end
