require 'rails_helper'

describe Place do
  it { should have_many :reviews }
  it { should have_and_belong_to_many :cuisines }

  it { should validate_presence_of :name }
  it { should validate_presence_of :street }
  it { should validate_presence_of :city }

  it 'should get coordinates when address is validated' do
    place = build :place, street: 'Some Street', city: 'Some City'
    place.valid?

    expect(place.latitude).to be == 12.345
    expect(place.longitude).to be == 98.765
  end

  it 'should not get coordinates when there are validation errors' do
    place = build :place, street: nil, city: 'Some City'
    place.valid?

    expect(place.latitude).to be nil
    expect(place.longitude).to be nil
  end
end
