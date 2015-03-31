require 'rails_helper'

describe UsersController, :type => :controller do
  let(:user) { create(:user) }

  describe "login user" do
    before do
      login_user(user)
    end

    describe "GET #show" do
      it "should get show" do
          get :show, id: user
          expect(response).to be_success
      end
    end

    describe "GET #edit" do
      it "should get edit" do
          get :edit, id: user
          expect(response).to be_success
      end
    end
  end

  describe "visitor" do
    describe "GET #show" do
      it "shold get show" do
        get :show, id: user
        expect(response).to redirect_to(login_path)
      end
    end

    describe "GET #edit" do
      it "should get edit" do
          get :edit, id: user
          expect(response).to redirect_to(login_path)
      end
    end
  end
end
