require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select '.pagination'
    User.page(1).per(10).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select '.pagination'
    first_page_of_users = User.page(1).per(10)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?][data-turbo-method="delete"]', user_path(user), text: '| DELETE'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin) 
  end
end

 test "index as non-admin" do
   log_in_as(@non_admin)
   get users_path
   assert_select 'a', text: 'delete', count: 0
  end 
end
