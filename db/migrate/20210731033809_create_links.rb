class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      # IE supports up to 2048 chars for URLs;
      # most browsers support more but highly unlikely we'll get a longer URL
      t.string :url, limit: 2048
      t.string :token
      t.timestamps
    end
    add_index :links, :token, unique: true
  end
end
