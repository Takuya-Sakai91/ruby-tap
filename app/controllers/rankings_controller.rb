# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    # 全ユーザーをベストスコア順にランキング表示（上位20件）
    @users = User.where.not(best_score: nil)
                 .order(best_score: :desc)
                 .limit(20)

    # 現在のユーザーがログインしていて、ランキングに含まれていない場合は、
    # 現在のユーザーの順位も取得
    if user_signed_in? && !@users.include?(current_user) && current_user.best_score.present?
      @current_user_rank = User.where.not(best_score: nil)
                               .where('best_score > ?', current_user.best_score)
                               .count + 1
    end
  end
end
