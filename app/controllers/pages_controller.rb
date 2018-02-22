class PagesController < ApplicationController
  def main
    @baseimage = Base.last
    @codeimage = Code.last
  end
end
