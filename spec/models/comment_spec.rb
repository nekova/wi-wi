require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe 'validations' do
    let(:comment) { build(:comment) }
    subject(:comment) { build(:comment, attr) }
    let(:attr) { { } }

    context 'when default' do
      it { expect(comment).to be_valid }
    end

    describe 'content' do
      context 'when blank' do
        let(:attr) { { content: '' } }
        it { expect(comment).to be_invalid }
      end
    end
  end
end
