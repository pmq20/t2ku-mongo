# -*- encoding : utf-8 -*-
class AccountController < ApplicationController
  before_filter :authenticate_user!
  def index

  end
  
  
end
