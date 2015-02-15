require 'rails_helper'

describe Cuisine do
  it { should have_and_belong_to_many :places }
  it { should validate_presence_of :name }
end
