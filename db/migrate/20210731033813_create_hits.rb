class CreateHits < ActiveRecord::Migration[6.1]
  def change
    create_table :hits do |t|
      t.string :ip
      t.references :link, index: true
      t.timestamps
    end
  end
end
