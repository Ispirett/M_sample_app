require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
 def setup
   @user = users(:Ispire)
   @micropost =  @user.microposts.build(content: 'Sweet')
 end

  test 'New Post should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present'do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

   test ' content should be valid ?' do
    @micropost.content = ' '
     assert_not @micropost.valid?
   end
  test 'Content should be at most 140 characters' do
    @micropost.content =  "a" * 200
    assert_not @micropost.valid?
  end

  test 'Content should be the latest' do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
