class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.string :image
      t.boolean :composited, default: false

      t.timestamps
    end
  end
end
