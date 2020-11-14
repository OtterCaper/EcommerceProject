class AboutController < ApplicationController
  def show
    @about = About.last
  end
end
