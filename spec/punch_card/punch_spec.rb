require 'spec_helper'

describe PunchCard::Punch do

  it 'has a valid in factory' do
    punch = FactoryGirl.create(:punch_in)
    expect(punch.name).not_to be_empty
    expect(punch.time).to be_within(5.seconds).of(Time.now)
    expect(punch.direction).to eq "in"
  end

  it 'has a valid out factory' do
    punch = FactoryGirl.create(:punch_out)
    expect(punch.name).not_to be_empty
    expect(punch.time).to be_within(5.seconds).of(Time.now)
    expect(punch.direction).to eq "out"
  end

end
