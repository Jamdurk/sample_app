class AddResetSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reset_sent_at, :datetime
  end
end
