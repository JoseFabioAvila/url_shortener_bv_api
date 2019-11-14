class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      # You'll want to add some attributes here...

      t.string  :title
      t.string  :full_url,   null: false, unique: true
      t.string  :short_code, unique: true
      t.integer :click_count, default: 0

      t.timestamps
    end
  end
end
