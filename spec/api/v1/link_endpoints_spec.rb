require 'rails_helper'

describe 'Links API' do
  Link.create(link: 'wolf', slug: 'wolf')
  Link.create(link: 'bear', slug: 'bear')
  Link.create(link: 'tiger', slug: 'tiger')

  it 'can get a list of links' do
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

  it 'can create a link' do
    link_name = 'hawk'

    post '/api/v1/links', params: { link: link_name }

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data][:type]).to eq('links')
    expect(link_data[:data][:attributes][:link]).to eq('hawk')
    expect(link_data[:data][:attributes][:slug]).to eq('hawk')
  end

  it 'can show individual link info from slug' do
    link = Link.first
    get "/api/v1/#{link.slug}"

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data][:type]).to eq('links')
    expect(link_data[:data][:attributes][:link]).to eq(link.link)
    expect(link_data[:data][:attributes][:slug]).to eq(link.slug)
  end
end