require 'rails_helper'

describe Link do
  describe 'relationships' do
    it { should have_many :clicks }
  end

  describe 'validations' do
    subject { Link.create(link: 'something', slug: 'something') }
    it { should validate_presence_of :link }
    it { should validate_uniqueness_of :slug }
  end
end