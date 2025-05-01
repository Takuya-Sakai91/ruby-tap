# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new; end

  def create
    @game = Game.new(remaining_time: 60, score: 0, correct_count: 0, wrong_count: 0)
    @game.user = current_user if user_signed_in?

    if @game.save
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
