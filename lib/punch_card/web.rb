get '/punches' do
  PunchCard::Punch.all.where(params).to_json
end

post '/punches' do
  PunchCard::Punch.create(params).save!
end
