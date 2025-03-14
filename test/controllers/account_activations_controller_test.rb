require "test_helper"

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end 

  test "only activated users have a valid user show page" do
    # Log in as fixture
    log_in_as(@user)
    # Assert user is activated
    assert @user.activated?
    # Takes us to the users page (all users)
    get users_path
    # Asserts we are at the users page
    assert_template 'users/index'
    # Select elements specifically the user themselves profile
    assert_select "a[href=?]", user_path(@user), count: 1
    # Creates user that has activation set to false
    unactivated_user = User.create(
                            name:  "Unactivated User",
                            email: "unactivated@example.com",
                            password:              "unactive",
                            password_confirmation: "unactive",
                            activated: false,
                            activated_at: nil 
    )
    # Reloading the index page to accurately make sure we check the newest version
    get users_path
    # Again checks elements that the unactivated user ir NOT present
    assert_select "a[href=?]", user_path(unactivated_user), count: 0
    # COnfirming the activated/logged-in user show page is accessible
    get user_path(@user)
    # Takes us to the user specific show page
    get user_path(unactivated_user)
    # Confirms we are redirecting as the user isnt activated
    assert_redirected_to root_url
   

  end 


end
