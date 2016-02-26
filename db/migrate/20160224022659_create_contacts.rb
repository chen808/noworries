class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true
      t.string :contact_name
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
    add_foreign_key :contacts, :users
  end
end
