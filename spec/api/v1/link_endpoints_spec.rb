require 'rails_helper'

describe 'Links API' do
  it 'can get a list of links' do
    Link.create(link: 'wolf', slug: 'wolf')
    Link.create(link: 'bear', slug: 'bear')
    Link.create(link: 'tiger', slug: 'tiger')

    get '/api/v1/links'

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data].length).to eq(3)
    expect(link_data[:data][0][:type]).to eq('links')
    expect(link_data[:data][0][:attributes][:link]).to eq('wolf')
    expect(link_data[:data][0][:attributes][:slug]).to eq('wolf')

    expect(link_data[:data][2][:type]).to eq('links')
    expect(link_data[:data][2][:attributes][:link]).to eq('tiger')
    expect(link_data[:data][2][:attributes][:slug]).to eq('tiger')
  end
end