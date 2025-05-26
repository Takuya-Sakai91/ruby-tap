# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    # games#indexは新規ゲーム作成ページとして機能
    redirect_to new_game_path
  end

  def show
    @game = Game.find(params[:id])
    @ruby_methods = @game.ruby_methods
  end

  def new; end

  def create
    @game = Game.new(remaining_time: 60, score: 0, correct_count: 0, wrong_count: 0)
    @game.user = current_user if user_signed_in?

    if @game.save
      # ランダムなRubyメソッドを追加
      add_methods_to_game(@game)
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 結果の表示
  def result
    @game = Game.find(params[:id])

    # ユーザーがログインしていて、このゲームに紐づいている場合
    if user_signed_in? && @game.user.present?
      # 現在のランキング（何位か）を取得
      @current_rank = User.where.not(best_score: nil)
                         .where('best_score > ?', @game.user.best_score)
                         .count + 1

      # 以前のベストスコアを記録
      @previous_best_score = @game.user.best_score_before_last_save

      # 前回のランキングを取得（比較用）
      @previous_rank = nil
      if @previous_best_score.present? && @previous_best_score != @game.user.best_score
        @previous_rank = User.where.not(best_score: nil)
                            .where('best_score > ?', @previous_best_score)
                            .count + 1
        # ランク変化を計算
        @rank_change = @previous_rank - @current_rank
      end
    end
  end

  # 出題されたメソッド一覧の表示
  def methods
    @game = Game.find(params[:id])
    # 正解数分だけメソッドを表示（最低1つは表示）
    count = [@game.correct_count, 1].max
    @ruby_methods = @game.ruby_methods.limit(count)
  end

  # ゲーム終了
  def finish
    @game = Game.find(params[:id])

    # パラメータでゲーム結果を更新
    @game.update(game_params)

    # ユーザーが関連付けられている場合、スコアを更新
    @game.user.update_scores(@game) if @game.user.present?

    redirect_to result_game_path
  end

  private

  def add_methods_to_game(game)
    # ランダムにRubyメソッドを取得
    methods = RubyMethod.order('RANDOM()')

    # ゲームにメソッドを追加
    methods.each_with_index do |method, index|
      game.game_methods.create(ruby_method: method, order: index)
    end
  end

  def game_params
    params.require(:game).permit(:correct_count, :wrong_count, :score)
  end
end
