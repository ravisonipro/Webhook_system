class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.text :note

      t.timestamps
    end
  end
end
