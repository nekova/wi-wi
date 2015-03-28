require 'rails_helper'

describe 'Profile access', feature: true do
  before do
    @user = create(:user)
  end

  describe "GET /login" do
    it { expect(new_user_session_path).not_to be_404_for :visitor }
  end
end
