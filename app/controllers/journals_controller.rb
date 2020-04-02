class JournalsController < ApplicationController
  before_action :authenticate_user!
  def index
    @token = current_user.token
  end
end
