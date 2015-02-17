class Cuisine < ActiveRecord::Base
  include Hateoas

  has_and_belongs_to_many :places

  validates :name, presence: true
end
