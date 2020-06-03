class CreateEnvironments < ActiveRecord::Migration[6.0]
  def change
    create_table :environments do |t|
      t.string :name
      t.string :private_key_path
      t.string :fqdn
      t.string :user_name

      t.timestamps
    end
  end
end
