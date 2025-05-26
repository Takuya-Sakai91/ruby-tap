# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    layout 'admin'

    private

    def authorize_admin!
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin?
    end
  end
end
