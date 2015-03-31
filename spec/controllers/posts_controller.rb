require 'rails_helper'

describe PostsController, :type => :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "login user" do
    before do
      login_user(user)
    end

    describe "Post#edit" do
      context "when his post" do
        it "shold accept #edit" do
          get :edit, id: post
          expect(response).to be_success
        end
      end

      context "when anybody post" do
        let(:another_post) { create(:post) }

        it "shold reject #edit" do
          get :edit, id: another_post
          expect(response).to redirect_to(post_path(another_post))
        end
      end
    end
  end

  describe "visitor" do
    describe "Post#edit" do
      it "shold accept to edit" do
        get :edit, id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "DELETE #destroy" do
      it "shold reject to destroy" do
        delete :destroy, id: post
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
