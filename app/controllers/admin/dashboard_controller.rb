# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def index
      @users_count = User.count
      @games_count = Game.count
      @top_methods = RubyMethod.left_joins(:game_methods)
                             .group(:id)
                             .order('COUNT(game_methods.id) DESC')
                             .limit(10)
                             .select('ruby_methods.*, COUNT(game_methods.id) as usage_count')
    end
  end
end
