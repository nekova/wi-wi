require 'rails_helper'

# RSpec.describe Post, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
#
# end
describe Post, type: :model do
  describe 'validations' do
    let(:post) { build(:post) }
    subject(:post) { build(:post, attr) }
    let(:attr) { { } }

    context 'when default' do
      it { expect(post).to be_valid }
    end

    describe 'title' do
      context 'when blank' do
        let(:attr) { { title: '' } }
        it { expect(post).to be_invalid }
      end

      context 'when too long' do
        let(:attr) { { title: 'a'*121 } }
        it { expect(post).to be_invalid }
      end
    end

    describe 'url' do
      context 'when blank' do
        let(:attr) { { url: '' } }
        it { expect(post).to be_invalid }
      end
    end
  end
end
