# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games, dependent: :destroy

  validates :best_score, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :previous_score, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
