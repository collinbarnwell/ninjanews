class NewspapersController < ApplicationController
  def index
    @newspapers = Newspaper.all
  end

  def show
    @newspaper = Newspaper.find(params[:id])
    @articles = @newspaper.articles
  end

  def create
    @newspaper = Newspaper.new(params[:newspaper])


    respond_to do |format|
      if @newspaper.save
        redirect_to @newspaper, notice: 'Newspaper was successfully created.'
      else
      end
    end
  end

  def destroy
    @newspaper = Newspaper.find(params[:id])
    @newspaper.destroy

  end
end
