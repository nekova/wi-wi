module Vote
  extend ActiveSupport::Concern

  included do
    def score
      self.get_upvotes.size - self.get_downvotes.size
    end

    def upvotable_by?(user)
      !(user.voted_up_on?(self)) && self.user != user
    end

    def downvotable_by?(user)
      !(user.voted_down_on?(self)) && self.user != user
    end
  end
end
