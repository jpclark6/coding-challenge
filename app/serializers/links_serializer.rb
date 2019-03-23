class LinksSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :link, :slug
end
