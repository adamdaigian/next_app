class StaticPagesController < ApplicationController
  def index
    @invitation ||= Invitation.new
  end

end
