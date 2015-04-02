require 'rails_helper'

describe Vote do
  describe "Post" do
    let(:user) { create(:user) }
    describe "#score" do
      let(:post) { create(:post) }
      context "when do nothing" do
        it { expect(post.score).to eq(0)}
      end

      context "when upvote once" do
        before { post.upvote_by(user) }
        it "return upvoted score" do
          expect(post.score).to eq(1)
        end
      end

      context "when downvote once" do
        before { post.downvote_by(user) }
        it "return downvoted score" do
          expect(post.score).to eq(-1)
        end
      end
    end
    
    # "#upvotable_by" and "#downvotable_by"
    describe "votable?" do
      let(:post) { create(:post) }
      let(:my_post) { create(:post, user: me) }
      let(:me) { create(:user) }

      context "when first vote" do
        it { expect(post.upvotable_by?(me)).to eq(true) }
      end

      context "when continue to upvote" do
        before { post.upvote_by(me) }
        it "rejects upvote" do
          expect(post.upvotable_by?(me)).to eq(false)
        end

        it "accepts downvote" do
          expect(post.downvotable_by?(me)).to eq(true)
        end
      end

      context "when continue to downvote" do
        before { post.downvote_by(me) }
        it "rejects downvote" do
          expect(post.downvotable_by?(me)).to eq(false)
        end

        it "accepts upvote" do
          expect(post.upvotable_by?(me)).to eq(true)
        end
      end

      context "when self-voting" do
        it { expect(my_post.upvotable_by?(me)).to eq(false) }
      end
    end
  end
end
