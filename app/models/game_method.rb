# frozen_string_literal: true

class GameMethod < ApplicationRecord
  belongs_to :game
  belongs_to :ruby_method
end
