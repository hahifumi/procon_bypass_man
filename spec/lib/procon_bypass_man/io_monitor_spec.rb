require "spec_helper"

describe ProconBypassMan::IOMonitor do
  before(:each) do
    ProconBypassMan::IOMonitor.reset!
  end

  describe '.new' do
    it do
      ProconBypassMan::IOMonitor.new(label: "hai")
      ProconBypassMan::IOMonitor.new(label: "hoge")
      expect(ProconBypassMan::IOMonitor.targets.size).to eq(2)
    end
  end

  describe '#record' do
    it do
      time = Time.now
      allow(Time).to receive(:now).and_return(time)
      monitor = ProconBypassMan::IOMonitor.new(label: "hai")
      monitor.record(:before_read)
      monitor.record(:before_read)
      monitor.record(:after_read)
      expect(monitor.table.values).to eq([{:before_read=>2, :after_read=>1}])
    end

    context '時間がずれるとき' do
      it do
        time = Time.now
        time2 = Time.now + 2
        allow(Time).to receive(:now).and_return(time)
        monitor = ProconBypassMan::IOMonitor.new(label: "hai")
        monitor.record(:before_read)
        monitor.record(:before_read)

        allow(Time).to receive(:now).and_return(time2)
        monitor.record(:after_read)
        monitor.record(:after_read)
        expect(monitor.previous_table).to eq(before_read: 2)
        expect(monitor.table.values).to eq([{:after_read=>2}])
      end
    end
  end

  describe 'Aggregation' do
    context do
      it do
        table = {
          start_function: 60,
          before_read: 28,
          after_read: 27,
          before_write: 20,
          after_write: 18,
          eagain_wait_readable_on_read: 3,
          eagain_wait_readable_on_write: 2,
          end_function: 16,
        }
        expect(ProconBypassMan::Aggregation.format(table)).to eq("(26.6%(16/60), loss: 3, 2)")
      end
    end
  end
end
