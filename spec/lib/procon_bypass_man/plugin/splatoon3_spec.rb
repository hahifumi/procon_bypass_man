require "spec_helper"

describe ProconBypassMan::Plugin::Splatoon3 do
  describe 'version' do
    it do
      expect(ProconBypassMan::Plugin::Splatoon3::VERSION).not_to be_nil
    end
  end

  it do
    expect(ProconBypassMan::Plugin::Splatoon3::Mode::Guruguru.binaries).to be_a(Array)
  end

  it do
    expect(ProconBypassMan::Plugin::Splatoon3::Macro::FastReturn.name).to eq('ProconBypassMan::Plugin::Splatoon3::Macro::FastReturn')
    expect(ProconBypassMan::Plugin::Splatoon3::Macro::FastReturn.steps).to eq([
      :x,
      :x,
      :x,
      :down,
      :down,
      :down,
      :down,
      :down,
      :toggle_a_for_0_1sec,
      :wait_for_0_5sec,
    ])
  end

  describe 'sokuwari' do
    it do
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::SokuwariForSplashBomb.name).to eq('ProconBypassMan::Plugin::Splatoon3::Macro::SokuwariForSplashBomb')
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::SokuwariForSplashBomb.steps).to eq([
        :toggle_r_for_0_2sec,
        :toggle_thumbr_for_0_14sec,
        :toggle_thumbr_and_toggle_zr_for_0_34sec,
        :toggle_r_for_1sec,
      ])
    end
  end

  describe 'charge_tansan_bomb' do
    it do
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::ChargeTansanBomb.name).to eq('ProconBypassMan::Plugin::Splatoon3::Macro::ChargeTansanBomb')
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::ChargeTansanBomb.steps).to eq([
        :shake_left_stick_and_toggle_b_for_0_1sec,
      ])
    end
  end

  describe 'ikarole' do
    it do
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::ForwardIkarole.name).to eq('ProconBypassMan::Plugin::Splatoon3::Macro::ForwardIkarole')
      expect(ProconBypassMan::Plugin::Splatoon3::Macro::ForwardIkarole.steps).to eq([
        :forward_ikarole1,
      ])
    end
  end
end
