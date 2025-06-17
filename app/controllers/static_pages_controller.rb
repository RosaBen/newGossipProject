class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [ :home, :contact, :team ]
  def contact
  end

def team
end

def home
end
end
