require 'rails_helper'

describe 'Links API' do
  before(:each) do
    link_1 = Link.create!(link: 'wolf', slug: 'wolf')
    link_2 = Link.create!(link: 'bear', slug: 'bear')
    link_3 = Link.create!(link: 'tiger', slug: 'tiger')

    Click.create(link: link_2)
    Click.create(link: link_2)
    Click.create(link: link_3)
  end

  it 'can get a list of links' do
    get '/api/v1/links'
    
    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data].length).to eq(3)
    expect(link_data[:data][0][:type]).to eq('links')
    expect(link_data[:data][0][:attributes][:link]).to eq('wolf')
    expect(link_data[:data][0][:attributes][:slug]).to eq('wolf')
    expect(link_data[:data][0][:attributes][:clicks]).to eq(0)

    expect(link_data[:data].length).to eq(3)
    expect(link_data[:data][1][:type]).to eq('links')
    expect(link_data[:data][1][:attributes][:link]).to eq('bear')
    expect(link_data[:data][1][:attributes][:slug]).to eq('bear')
    expect(link_data[:data][1][:attributes][:clicks]).to eq(2)

    expect(link_data[:data][2][:type]).to eq('links')
    expect(link_data[:data][2][:attributes][:link]).to eq('tiger')
    expect(link_data[:data][2][:attributes][:slug]).to eq('tiger')
    expect(link_data[:data][2][:attributes][:clicks]).to eq(1)
  end

  it 'can create a link' do
    link_name = 'hawk'

    post '/api/v1/links', params: { link: link_name }

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data][:type]).to eq('links')
    expect(link_data[:data][:attributes][:link]).to eq('hawk')
    expect(link_data[:data][:attributes][:slug]).to eq('hawk')
    expect(link_data[:data][:attributes][:clicks]).to eq(0)
  end

  it 'cannot create a link with a name that is already used' do
    link_name = 'hawk'
    post '/api/v1/links', params: { link: link_name }

    link_name = 'hawk'
    post '/api/v1/links', params: { link: link_name }

    expect(response.status).to eq(404)
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:error]).to eq('post unsuccessful')
  end

  it 'can show individual link info from slug' do
    link = Link.first
    get "/api/v1/links/#{link.slug}"

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data][:type]).to eq('links')
    expect(link_data[:data][:attributes][:link]).to eq(link.link)
    expect(link_data[:data][:attributes][:slug]).to eq(link.slug)
    expect(link_data[:data][:attributes][:clicks]).to eq(link.clicks.count)
  end

  it 'fails gracefully when slug show not found' do
    link = Link.first
    get "/api/v1/links/#{link.slug + 'nope'}"

    expect(response.status).to eq(404)
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:error]).to eq('cannot find link')
  end

  it 'can delete a link' do
    link = Link.first
    delete "/api/v1/links/#{link.slug}"

    expect(response).to be_successful
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:data][:type]).to eq('links')
    expect(link_data[:data][:attributes][:link]).to eq(link.link)
    expect(link_data[:data][:attributes][:slug]).to eq(link.slug)
    expect(link_data[:data][:attributes][:clicks]).to eq(link.clicks.count)
  end

  it 'fails gracefully when slug delete not found' do
    link = Link.first
    delete "/api/v1/links/#{link.slug + 'nope'}"

    expect(response.status).to eq(404)
    link_data = JSON.parse(response.body, symbolize_names: true)

    expect(link_data[:error]).to eq('cannot find link')
  end
end