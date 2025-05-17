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
end
