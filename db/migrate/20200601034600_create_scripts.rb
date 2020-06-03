class CreateScripts < ActiveRecord::Migration[6.0]
  def change
    create_table :scripts do |t|
      t.string :title
      t.text :code
      t.string :aasm_state
      t.string :path_to_application
      t.string :command

      t.timestamps
    end
  end
end
