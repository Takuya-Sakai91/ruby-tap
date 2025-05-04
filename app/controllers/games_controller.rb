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

  private

  def add_methods_to_game(game)
    # ランダムにRubyメソッドを取得
    methods = RubyMethod.order('RANDOM()')

    # ゲームにメソッドを追加
    methods.each_with_index do |method, index|
      game.game_methods.create(ruby_method: method, order: index)
    end
  end
end
