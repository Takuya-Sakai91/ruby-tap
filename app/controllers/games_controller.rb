# frozen_string_literal: true

class GamesController < ApplicationController
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
