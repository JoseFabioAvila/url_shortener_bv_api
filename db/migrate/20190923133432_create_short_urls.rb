class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      # You'll want to add some attributes here...

      t.string  :code,  null: false, unique: true
      t.string  :url,  null: false, unique: true
      t.integer :visits, default: 0
      t.string  :title

      t.timestamps
    end
  end
end
