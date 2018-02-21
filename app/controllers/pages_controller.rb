class PagesController < ApplicationController
  def main
    @baseimage = Base.last
    @codeimages = Code.all
  end
end
