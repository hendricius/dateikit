class StaticController < ApplicationController
  skip_before_filter :check_auth_token

  def home
  end

end
