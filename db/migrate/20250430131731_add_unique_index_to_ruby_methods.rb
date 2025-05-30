# frozen_string_literal: true

class AddUniqueIndexToRubyMethods < ActiveRecord::Migration[7.1]
  def change
    add_index :ruby_methods, [:name, :ruby_module_id], unique: true
  end
end
