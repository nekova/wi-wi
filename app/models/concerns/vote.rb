module Vote
  extend ActiveSupport::Concern

  included do
    def score
      self.get_upvotes.size - self.get_downvotes.size
    end
  end
end
