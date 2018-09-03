class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :null_session
  before_action :admin_signed_in?, except:[:index, :show]
end
