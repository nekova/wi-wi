require 'rails_helper'

describe CommentsController, :type => :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, post: post, user: user) }

  describe "login user" do
    before do
      login_user(user)
    end

    describe "Comment#edit" do
      context "when his post" do
        it "shold accept #edit" do
          get :edit, id: comment, post_id: post
          expect(response).to be_success
        end
      end

      context "when anybody post" do
        let(:another_comment) { create(:comment, user: build(:user)) }

        it "shold reject to edit" do
          get :edit, id: another_comment, post_id: post
          expect(response).to redirect_to(post_path(comment.post))
        end
      end
    end
  end

  describe "visitor" do
    describe "GET #edit" do
      it "shold reject to edit" do
        get :edit, id: comment, post_id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "POST #create" do
      it "shold reject to create" do
        post :create, id: comment, post_id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "DELETE #destroy" do
      it "shold reject to destroy" do
        delete :destroy, id: comment, post_id: post
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
