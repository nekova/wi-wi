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
    #something wrong
    describe "GET #show" do
      it "shold reject to show" do
        get :show, id: user
        expect(response).to redirect_to(login_path)
      end
    end

    describe "GET #edit" do
      it "should reject to edit" do
          get :edit, id: user
          expect(response).to redirect_to(login_path)
      end
    end

    describe "DELETE #destroy" do
      it "should reject to destroy" do
          delete :destroy, id: user
          expect(response).to redirect_to(login_path)
      end
    end
  end
end
