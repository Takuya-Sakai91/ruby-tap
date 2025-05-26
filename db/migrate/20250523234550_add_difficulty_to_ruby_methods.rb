# frozen_string_literal: true

class AddDifficultyToRubyMethods < ActiveRecord::Migration[7.1]
  def change
    add_column :ruby_methods, :difficulty, :string, default: 'beginner'

    # 既存のレコードのdifficultyを'beginner'に設定
    reversible do |dir|
      dir.up do
        execute "UPDATE ruby_methods SET difficulty = 'beginner' WHERE difficulty IS NULL"
      end
    end
  end
end
