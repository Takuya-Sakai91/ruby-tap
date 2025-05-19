# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games, dependent: :destroy

  validates :best_score, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :previous_score, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: I18n.t('activerecord.errors.models.user.attributes.username.invalid_format') }

  def display_name
    username.presence || email.split('@').first
  end

  # 新しいゲーム結果に基づいてスコアを更新する
  def update_scores(new_game)
    # 前回のスコアを更新（直近のゲーム結果を取得）
    self.previous_score = games.where.not(id: new_game.id).order(created_at: :desc).first&.correct_count.to_i || 0

    # ベストスコアを更新（現在のスコアがベストスコアより高い場合）
    self.best_score = new_game.correct_count.to_i if best_score.nil? || new_game.correct_count > best_score

    save
  end
end
