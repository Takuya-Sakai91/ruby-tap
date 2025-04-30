# frozen_string_literal: true

class GameMethod < ApplicationRecord
  belongs_to :game
  belongs_to :ruby_method

  validates :order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ruby_method_id, uniqueness: { scope: :game_id }
end
