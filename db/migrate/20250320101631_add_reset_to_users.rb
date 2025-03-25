class AddResetToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reset_digest, :string
  end
end
