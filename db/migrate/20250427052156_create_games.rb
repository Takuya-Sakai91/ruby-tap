# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :remaining_time, null: false, default: 60
      t.decimal :score, null: false, default: 0
      t.integer :correct_count, null: false, default: 0
      t.integer :wrong_count, null: false, default: 0
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
