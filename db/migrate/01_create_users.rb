class CreateUsers < ActiveRecord::Migration[4.2]
    def change
        create_table :users do |user|
            user.string :username
            user.text :email
            user.string :password_digest
            user.string :tweets
        end
    end

end