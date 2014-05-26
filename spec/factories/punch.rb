FactoryGirl.define do
  factory :punch, class: PunchCard::Punch do
    name "a punch"
    time Time.now
    direction "in"

    factory :punch_in do
      direction "in"
    end

    factory :punch_out do
      direction "out"
    end
  end
end
