# frozen_string_literal: true

class AddUniqueIndexToGameMethods < ActiveRecord::Migration[7.1]
  def change
    add_index :game_methods, [:ruby_method_id, :game_id], unique: true
  end
end
