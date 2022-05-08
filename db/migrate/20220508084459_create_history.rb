class CreateHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.string :attribute_name
      t.string :before_value
      t.string :after_value
      t.integer :owner_id
      t.references :historyable, polymorphic: true
      t.timestamps
    end
  end
end
