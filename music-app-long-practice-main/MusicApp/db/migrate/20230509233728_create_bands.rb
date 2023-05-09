class CreateBands < ActiveRecord::Migration[7.0]
  def change
    create_table :bands do |t|
      t.string :bandname

      t.timestamps
    end
  end
end
