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

    describe "vote" do
      let(:anycomment) { create(:comment) }

      describe "PUT #upvote" do
        context "when default vote" do
          it "should accept to vote" do
            put :upvote, id: anycomment
            expect(response).to redirect_to(anycomment.post)
          end
        end

        context "when self-voting" do
          it "should reject to vote" do
            put :upvote, id: comment
            expect(response).to redirect_to(comment.post)
            expect(flash[:notice]).to eq("You can't vote")
          end
        end

        context "when continue to vote" do
          before do
            put :upvote, id: anycomment
          end

          it "should reject to vote" do
            put :upvote, id: anycomment
            expect(response).to redirect_to(anycomment.post)
            expect(flash[:notice]).to eq("You can't vote")
          end
        end
      end

      describe "PUT #downvote" do
        context "when default vote" do
          it "should accept to vote" do
            put :downvote, id: anycomment
            expect(response).to redirect_to(anycomment.post)
          end
        end

        context "when self-voting" do
          it "should reject to vote" do
            put :downvote, id: comment
            expect(flash[:notice]).to eq("You can't vote")
          end
        end

        context "when continue to vote" do
          before do
            put :downvote, id: anycomment
          end

          it "should reject to vote" do
            put :downvote, id: anycomment
            expect(response).to redirect_to(anycomment.post)
            expect(flash[:notice]).to eq("You can't vote")
          end
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

    describe "DELETE #destroy" do
      it "shold reject to destroy" do
        delete :destroy, id: comment, post_id: post
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
