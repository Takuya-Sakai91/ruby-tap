# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user, optional: true
  has_many :game_methods, dependent: :destroy
  has_many :ruby_methods, through: :game_methods

  validates :remaining_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :correct_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :wrong_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
