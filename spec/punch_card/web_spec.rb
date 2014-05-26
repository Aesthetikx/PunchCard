require 'spec_helper'

describe 'Sinatra Web Frontend' do

  context 'get#punches' do
    it 'serves punches' do
      3.times { FactoryGirl.create(:punch) }
      get '/punches'
      data = JSON.parse(last_response.body)
      expect(data.length).to eq 3
    end

    it 'handles name param' do
      FactoryGirl.create(:punch, name: "Project One")
      FactoryGirl.create(:punch, name: "Project One")
      FactoryGirl.create(:punch, name: "Project Two")

      get '/punches', name: 'Project One'
      data = JSON.parse(last_response.body)

      data.each do |punch|
        expect(punch['name']).to eq 'Project One'
      end
    end

    it 'handles direction param' do
      FactoryGirl.create(:punch_in)
      FactoryGirl.create(:punch_out)

      get '/punches', direction: 'in'
      data = JSON.parse(last_response.body)

      data.each { |punch| expect(punch['direction']).to eq('in') }
    end
  end

  context 'post#punches' do
    it 'creates a punch' do
      name = 'Project'
      direction = 'out'
      time = Time.now

      post '/punches', {name: name, direction: direction, time: time}
      expect(last_response).to be_ok

      punch = PunchCard::Punch.last
      expect(punch.name).to eq(name)
      expect(punch.direction).to eq(direction)
      expect(punch.time.to_i).to eq(time.to_i)
    end
  end

end
