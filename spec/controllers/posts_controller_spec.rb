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

    describe "vote" do
      let(:anypost) { create(:post) }

      describe "PUT #upvote" do
        context "when default vote" do
          it "should accept to vote" do
            put :upvote, id: anypost
            expect(response).to redirect_to(anypost)
          end
        end

        context "when self-voting" do
          it "should reject to vote" do
            put :upvote, id: post
            expect(response).to redirect_to(post)
            expect(flash[:notice]).to eq("You can't vote")
          end
        end

#Database
        # context "when continue to vote" do
        #   it "should reject to vote" do
        #     put :upvote, id: post
        #     expect(response).to redirect_to(post)
        #     expect(flash[:notice]).to eq("You can't vote")
        #   end
        # end
      end

      describe "PUT #downvote" do
        context "when default vote" do
          it "should accept to vote" do
            put :upvote, id: anypost
            expect(response).to redirect_to(anypost)
          end
        end

        context "when self-voting" do
          it "should reject to vote" do
            put :upvote, id: post
            expect(response).to redirect_to(post)
            expect(flash[:notice]).to eq("You can't vote")
          end
        end
#Database
        # context "when continue to vote" do
        #   it "should reject to vote" do
        #     put :upvote, id: post
        #     expect(response).to redirect_to(post)
        #     expect(flash[:notice]).to eq("You can't vote")
        #   end
        # end
      end
    end
  end

  describe "visitor" do
    describe "GET #edit" do
      it "shold accept to edit" do
        get :edit, id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "DELETE #destroy" do
      it "should reject to destroy" do
        delete :destroy, id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "PUT #upvote" do
      it "shold reject to vote" do
        put :upvote, id: post
        expect(response).to redirect_to(login_path)
      end
    end

    describe "PUT #downvote" do
      it "shold reject to vote" do
        put :downvote, id: post
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
