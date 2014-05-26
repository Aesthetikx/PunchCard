require 'spec_helper'
require 'stringio'

describe PunchCard do

  it 'detects the current git repository' do
    expect(PunchCard.current_git).not_to be_nil
    expect(PunchCard.current_git).to eq 'PunchCard'
  end

  context 'punching' do
    it 'creates a punch for punch_in' do
      PunchCard.punch_in Faker::Lorem.words(3).join("_")
      expect(PunchCard::Punch.last.direction).to eq "in"
      expect(PunchCard::Punch.last.time).to be_within(5.seconds).of(Time.now)
    end

    it 'creates a punch for punch_out' do
      PunchCard.punch_out Faker::Lorem.words(3).join("_")
      expect(PunchCard::Punch.last.direction).to eq "out"
      expect(PunchCard::Punch.last.time).to be_within(5.seconds).of(Time.now)
    end
  end

  context 'duration' do

    before do
      @name = Faker::Lorem.words(3).join("_")
    end

    it 'calculates the duration between two punches' do
      PunchCard.punch_in @name

      Timecop.freeze(Time.now + 2.hours + 3.minutes) do
        PunchCard.punch_out @name
      end

      duration = PunchCard.last_duration @name

      expect(duration).to be_within(5.seconds).of(2.hours + 3.minutes)
    end

  end

  context 'status' do

    before do
      $stdout = StringIO.new
      @name = Faker::Lorem.words(3).join(" ")
    end

    after(:all) do
      $stdout = STDOUT
    end

    it 'prints status for inactive punch' do
      PunchCard.punch_out @name
      PunchCard.punch_status @name
      msg = "PunchCard: not punched in.\n"
      expect($stdout.string).to eq(msg)
    end

    it 'prints status for active punch' do
      PunchCard.punch_in @name

      Timecop.freeze(Time.now + 2.hours) do
        PunchCard.punch_status @name
      end

      msg = "PunchCard: punched into #{@name} for about 2 hours.\n"
      expect($stdout.string).to eq(msg)
    end
  end

end
