require "spec_helper"

describe ProconBypassMan::TimeScopedMap do
  it do
    map = ProconBypassMan::TimeScopedMap.new
    Timecop.freeze do
      map.add 1
      map.add 2
      expect(map.result).to eq({ list: nil })
    end
  end

  it do
    map = ProconBypassMan::TimeScopedMap.new
    Timecop.freeze do
      map.add 1
      map.add 2
    end

    Timecop.freeze(Time.now + 1) do
      map.add 1
      expect(map.result).to eq({ list: [1, 2] })
    end
  end

  it do
    map = ProconBypassMan::TimeScopedMap.new
    Timecop.freeze do
      map.add(1) { raise "do not call" }
      map.add(2) { raise "do not call" }
    end

    Timecop.freeze(Time.now + 1) do
      map.add(1) { |result| expect(result).to eq({ list: [1, 2] }) }
      expect(map.result).to eq({ list: [1, 2] })
    end
  end
end
