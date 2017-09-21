class CreateShortUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :short_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :number_of_hits
      t.timestamps
    end
  end
end
