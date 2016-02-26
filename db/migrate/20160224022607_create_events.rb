class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.string :event
      t.text :comment
      t.integer :completion
      t.string :contact
      t.string :ph
      t.string :email

      t.timestamps null: false
    end
    add_foreign_key :events, :users
  end
end
