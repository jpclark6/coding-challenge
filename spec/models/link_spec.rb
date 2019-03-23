require 'rails_helper'

describe Link do
  describe 'relationships' do
    it { should have_many :clicks }
  end

  describe 'validations' do
    it { should validate_presence_of :link }
    it { should validate_uniqueness_of :slug }
  end
end