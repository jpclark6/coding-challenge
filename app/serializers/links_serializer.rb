class LinksSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :link, :slug

  attribute :clicks do |link|
    link.clicks.count
  end
end
