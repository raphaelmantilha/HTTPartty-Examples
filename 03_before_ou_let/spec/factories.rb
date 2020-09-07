require_relative "models/user_model"

FactoryBot.define do

    factory :user, class: UserModel do
        full_name { "Papito Skywalker"}
        email {"papito@jedi.com"}
        password {"jedi123"}

        after(:build) do |user|
            Database.new.delete_user(user.email)
        end
    end

    factory :registered_user, class: UserModel do
        full_name { "Anakin Skywalker"}
        email {"anakin@jedi.com"}
        password {"darthvader"}

        after(:build) do |user|
            Database.new.delete_user(user.email)
            ApiUser.save(user.to_hash)
        end
    end

    factory :user_wrong_email, class: UserModel do
        full_name { "Papito Skywalker"}
        email {"papito#jedi.com"}
        password {"jedi123"}
    end

    factory :empty_name_user, class: UserModel do
        full_name {""}
        email {"papito@jedi.com"}
        password {"jedi123"}
    end

    factory :empty_email_user, class: UserModel do
        full_name {"Fernando Papito"}
        email {""}
        password {"jedi123"}
    end

    factory :empty_password_user, class: UserModel do
        full_name {"Fernando Papito"}
        email {"papito@jedi.com"}
        password {""}
    end

    factory :null_full_name, class: UserModel do
        email {"anakin@jedi.com"}
        password {"darthvader"}
    end

    factory :null_email, class: UserModel do
        full_name { "Anakin Skywalker"}
        password {"darthvader"}
    end

    factory :null_password, class: UserModel do
        full_name { "Anakin Skywalker"}
        email {"anakin@jedi.com"}
    end
end