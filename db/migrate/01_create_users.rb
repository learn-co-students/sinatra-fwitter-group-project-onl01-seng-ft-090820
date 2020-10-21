class CreateUsers < ActiveRecord::Migration[4.2]
    def change
        create_table :users do |user|
            user.string :username
            user.string :email
            user.string :password_digest
        end
    end

end