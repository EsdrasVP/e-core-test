require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { described_class.new(name: name) }

  context 'when name is valid' do
    let(:name) { 'Developer' }

    it { is_expected.to be_valid }
  end

  context 'when name is invalid' do
    let(:name) { nil }

    it { is_expected.to_not be_valid }
  end

  context 'when name already taken' do
    let(:name) { 'Developer' }
    
    before do
      Role.create(name: 'Developer')
    end
    
    it { is_expected.to_not be_valid }
  end
end