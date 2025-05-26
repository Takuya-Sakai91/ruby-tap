class AddDescriptionToRubyModules < ActiveRecord::Migration[7.1]
  def change
    add_column :ruby_modules, :description, :text
  end
end
