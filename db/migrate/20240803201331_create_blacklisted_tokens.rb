class CreateBlacklistedTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :blacklisted_tokens do |t|
      t.string :token
      t.datetime :expired_at

      t.timestamps
    end
  end
end
