# frozen_string_literal: true

class CreateRubyModules < ActiveRecord::Migration[7.1]
  def change
    create_table :ruby_modules do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :ruby_modules, :name, unique: true
  end
end
