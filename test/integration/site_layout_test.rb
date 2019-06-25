require 'test_helper'
class SiteLayoutTest < ActionDispatch::IntegrationTest
   test "site_layouts" do
     get root_path
     assert_template 'static_pages/home'

     assert_select 'a[href=?]', root_path,  count: 1
     assert_select 'a[href=?]', about_path, count: 2
     assert_select 'a[href=?]', help_path, count: 1
     assert_select 'a[href=?]', contact_path, count:2
     assert_select 'a[href=?]', sign_up_path
     get contact_path
     assert_select "title", full_title("Contact")
     get sign_up_path
     assert_select 'title', full_title('SignUp')
    end

end
