class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :name
      t.integer :telephone
      t.string :enterprise
      t.timestamps
    end
  end
end
