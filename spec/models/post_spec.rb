require 'rails_helper'

# RSpec.describe Post, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
#
# end
describe Post do
  it "has a valid" do
    expect(create(:post)).to be_valid
  end
end
