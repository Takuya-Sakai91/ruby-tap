# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: I18n.t('users.access_denied') unless @user == current_user
  end
end
