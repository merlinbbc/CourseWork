class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @tsaks = []
    else
      @tasks = Task.search params[:q]
    end
  end
end
