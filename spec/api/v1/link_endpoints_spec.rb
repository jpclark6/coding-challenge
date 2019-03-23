require 'rails_helper'

describe 'Links API' do
  it 'can get a list of links' do
    Link.create(link: 'wolf', slug: 'wolf')
    Link.create(link: 'bear', slug: 'bear')
    Link.create(link: 'tiger', slug: 'tiger')

    get '/api/v1/links'

    expect(response).to be_successful
    link_data = JSON.parse(response.body)
    expect(link_data[:data].length).to eq(3)
  end
end