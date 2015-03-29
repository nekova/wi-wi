require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }
    subject(:user) { build(:user, attr) }
    let(:attr) { { } }

    context 'when default' do
      it { expect(user).to be_valid }
    end

    describe 'name' do
      context 'when blank' do
        let(:attr) { { name: '' } }
        it { expect(user).to be_invalid }
      end

      context 'when duplicated' do
        let!(:existing_user) { create(:user) }
        let(:attr) { { name: existing_user.name } }
        it { expect(user).to be_invalid }
      end

      context 'when too long' do
        let(:attr) { { name: "a"*33 } }
        it { expect(user).to be_invalid }
      end
    end

    describe 'email' do
      context 'when blank' do
        let(:attr) { { email: '' } }
        it { expect(user).to be_invalid }
      end

      context 'when duplicated' do
        let(:existing_user) { create(:user) }
        let(:attr) { { email: existing_user.email } }
        it { expect(user).to be_invalid }
      end
    end

    describe 'password' do
      context 'when too short' do
        let(:attr) { { email: 'ps' } }
        it { expect(user).to be_invalid }
      end
    end
  end
end
