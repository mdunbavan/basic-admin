# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: 'User' do
    email 'example@example.com'
    password 'password1'
    admin false
    name "My Lovely Name"
  end

  factory :admin_user, class: 'User' do
    email 'admin-example@example.com'
    password 'password1'
    admin true
    name "My Lovely Admin"
  end

end
