require "spec_helper"

describe ProconBypassMan::Outbound::HasRoundRobinServer do
  let(:target) { ProconBypassMan::Outbound::HasRoundRobinServer::RoundRobinServer }
  describe '#pick' do
    context 'when provide a nil' do
      it do
        picker = target.new(servers: nil)
        expect(picker.pick).to be_nil
        expect(picker.pick).to be_nil
      end
    end

    context 'when provide a empty array' do
      it do
        picker = target.new(servers: [])
        expect(picker.pick).to be_nil
      end
    end

    context 'when provide an array has a item' do
      it do
        picker = target.new(servers: [1])
        expect(picker.pick).to eq(1)
        expect(picker.pick).to eq(1)
      end
    end

    context 'when provide an array has two items' do
      it 'rotate' do
        picker = target.new(servers: [1, 2])
        expect(picker.pick).to eq(1)
        expect(picker.pick).to eq(1)
        picker.next!
        expect(picker.pick).to eq(2)
        picker.next!
        expect(picker.pick).to eq(1)
      end
    end
  end
end
