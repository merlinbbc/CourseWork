class SearchController < ApplicationController
  def search
      if params[:q].nil?
        @tasks = []
      else
        @tasks = Task.search params[:q]
      end
  end
end
