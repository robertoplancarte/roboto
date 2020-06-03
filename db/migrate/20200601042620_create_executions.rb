class CreateExecutions < ActiveRecord::Migration[6.0]
  def change
    create_table :executions do |t|
      t.string :aasm_state
      t.datetime :started_at
      t.datetime :finished_at
      t.string :input
      t.string :output
      t.references :user, null: false, foreign_key: true
      t.references :environment, null: false, foreign_key: true
      t.references :script, null: false, foreign_key: true

      t.timestamps
    end
  end
end
