class Link < ApplicationRecord
  validates_uniqueness_of :slug
  validates :link, presence: true
  validates :slug, presence: true

  has_many :clicks, dependent: :destroy

  def to_param
    slug
  end
end