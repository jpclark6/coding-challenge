require 'rails_helper'

describe Click do
  describe 'relationships' do
    it { should belong_to :link }
  end
end