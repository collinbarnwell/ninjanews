class SourcesController < ApplicationController
  def new
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @source = Source.new
    @feeds = Feed.all
  end

  def create
    return unless current_user.is_admin
    @source = Source.new(source_params)
    if @source.save
      redirect_to :back, notice: "Source (#{@source.title} created."
    else
      render action: 'new'
    end
  end

  def edit
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @source = Source.find(params[:id])
  end

  def update
    return unless current_user.is_admin
    @source = Source.find(params[:id])
    if @source.update_attributes(source_params)
      redirect_to :back, notice: 'Source updated.'
    else
      render action: 'new'
    end
  end

  def index
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @sources = Source.all
  end

  def destroy
    return unless current_user.is_admin
    Source.find(params[:id]).destroy
    redirect_to sources_path, notice: 'Source destroyed.'
  end

  private

    def source_params
      params.require(:source).permit(:title, :url, :area)
    end
end
