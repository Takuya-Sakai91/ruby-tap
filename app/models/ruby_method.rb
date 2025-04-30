# frozen_string_literal: true

class RubyMethod < ApplicationRecord
  belongs_to :ruby_module
  has_many :game_methods, dependent: :destroy
  has_many :games, through: :game_methods

  validates :name, presence: true
  validates :class_name, presence: true
  validates :name, uniqueness: { scope: :ruby_module_id }
end
