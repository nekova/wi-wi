require 'spec_helper'

describe User do
  describe 'validations' do
    describe 'name' do
      it 'rejects nekova-' do
        user = build(:user, name: 'nekova-')
        expect(user).to be_invalid
      end
    end
  end
end
