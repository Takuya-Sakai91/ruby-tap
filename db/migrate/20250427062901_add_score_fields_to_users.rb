# frozen_string_literal: true

class AddScoreFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :best_score, :decimal, default: 0
    add_column :users, :previous_score, :decimal, default: 0
  end
end
