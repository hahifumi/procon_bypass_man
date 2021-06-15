class ProconBypassMan::Procon
  module Data
    NO_ACTION = "30f28100800078c77448287509550274ff131029001b0022005a0271ff191028001e00210064027cff1410280020002100000000000000000000000000000000"
    MEANINGLESS = [
      "309481408000362d684658750968f71cfe2c0e51000001480053f71ffedf0d4b000a013d00caf6ecfd4c0d480003011c00000000000000000000000000000000",
      "30978140800037dd6748687509fdf6adfded0d6d0081005d00eef68dfdef0d6d00830059001bf791fd140e720090005400000000000000000000000000000000",
      "309a8140800038cd67495875099af821fe120e40006400880042f8fcfdfd0d470067008900d4f7e0fdf20d4e006a008c00000000000000000000000000000000",
      "309c8140800036ed67466875099bf878fe4a0e35005b004c00c1f875fe400e35005d004c00c4f856fe2d0e390063006c00000000000000000000000000000000",
      "30a081408000371d6847587509b9f71bfee70d22002c002300e3f73afe150e2b003500280014f854fe300e2d0038002900000000000000000000000000000000",
      "30a38140800039fd6743587509def70ffea10d1a0031001f00d1f70ffeb10d19002c002200c5f711feb80d18002c002500000000000000000000000000000000",
      "30a58140800037dd6746687509d8f70bfe980d270035001200ddf70dfe980d240038001900dff70ffe9b0d1f0035001a00000000000000000000000000000000",
      "30a98140800037ed67484875099cf7edfdb00d310020000d009ef7eefda30d310022000c00adf7f2fd980d300028000a00000000000000000000000000000000",
      "30ac8140800036ed67484875099cf709fed40d3a002400160097f7fafdd30d39002200150096f7f0fdc80d380022001400000000000000000000000000000000",
      "30ae8140800038fd674558750987f72efed40d360021001c0089f729fed50d39002400180092f715fed10d390022001800000000000000000000000000000000",
      "30b18140800037dd6747487509b8f705fea90d19001d002000c5f70dfeb00d210019002200bff71efec20d280018002400000000000000000000000000000000",
      "30b48140800038fd684868750980f7e9fdd40d0200080024007df7f1fdba0d060011001e0084f7f8fdaa0d12001a001a00000000000000000000000000000000",
      "30b7814080003fdd694958750918f6a9fd510f0d00d1ff370024f7b0fda90e0100ecff30006cf7d1fd210efffff5ff2c00000000000000000000000000000000",
      "30ba81408080482d744768750963f71ffe190f5e00d9fea100ccf62dfe650f510009ff980015f702fe580f4b002eff8400000000000000000000000000000000",
      "30bd814080802f7d864758750974f70efe4c0f5e00c0fea000d1f726fe1c0f5d00c5fea30028f859fe0e0f5c00cafea800000000000000000000000000000000",
      "30bf8140808057cc984758750961f73afe630f99009dfeae0050f738fe710f7500adfea40050f721fe720f6e00b2fea300000000000000000000000000000000",
      "30c281408080f479bd483875092ef8b6feab0f0a0180feba00f1f798fe900f000181febd00c2f77dfe7c0fdb008efebd00000000000000000000000000000000",
      "30c581408080ad87d846487509e1f80000a6107e0178fea2004ef88dff54106c0185fea70063f826ffe60f520182feae00000000000000000000000000000000",
      "30c8810080800797d84868750995f8e1fe4b0f7a0161fe88000df96dffd00f700149fe990035f9cdff361088016afea000000000000000000000000000000000",
      "30cb810080804586d848487509cef672fe8a0f6d0217ff42002df63cfe280f1d0219ff410059f61cfe070fed01f5fe4a00000000000000000000000000000000",
      "30d08100808002c5d745687509d8f5aaff830f5e03e6fe3e01fbf55bffc30f3f03e4fe100158f600ff3e102903e5fee700000000000000000000000000000000",
      "30d3810080807b94d14838750991f6cd00690f9903f0fff10147f6e200560f7e038fffc60101f6c900560f71033bffa901000000000000000000000000000000",
      "30d681008080b743ca475875095af7f2009c0fca03a400320242f7ca00950fb503820028020af7b000820fa4034e001a02000000000000000000000000000000",
      "30d9810080805be3c047587509e7f77a03c70f0e04bb00410258f79801940f0004b800410251f74401910fd803b3003602000000000000000000000000000000",
      "30dc810080808a02b245587509c0fbd5086a10710475020a03b0fb8d085d106c042102e8027efb660876106a04bc01af02000000000000000000000000000000",
      "30de8100808036d2a14568750970fbbf09ad103704af038003a9fb600989105c0459036103c2fb2a097210690412034603000000000000000000000000000000",
      "30e281008000cbb18d4738750989f8b40b2812380341044c0429f99e0bef11510340043704f2f93c0b7911b0033704f003000000000000000000000000000000",
      "30e581008000c9c18945587509a5f7ca0a2e13e400c6024c0547f7fd0a941264011703270578f74a0b6012e40168030205000000000000000000000000000000",
      "30e781008000c6618948687509acf86909e813d0fe2801a1057cf8cf09ed130fff6301990516f8710aaa13ccff13028205000000000000000000000000000000",
      "30ea81008000c77189475875093af93b0762136efbaeff19060cf90107b113a9fb99ff0906e1f85b07b113bafc9fffcd05000000000000000000000000000000",
      "30ed81008000c791894568750950f9ce047c1432f900026007a5f9a6051f146ef9bb013707bff99206a813fef9ce00c606000000000000000000000000000000",
      "30ef81008000c6d1894558750944f8ad0358143ef81c02f10780f8b403841484f84102d107ccf801049314bcf84202ad07000000000000000000000000000000",
      "30f381008000c761884868750914f72105e4134cf6d001c00743f71a05f11391f6bf01e407a0f7c904fa13faf6b3011008000000000000000000000000000000",
      "30f681008000c7718344587509eaf54a04c812a6f40002500627f66d041313f2f40d02940682f6a60468133ef51a02d806000000000000000000000000000000",
      "30f881008000c4e1814668750b5cf5f803b51125f3b5000d0560f50f04e8118cf33c015d057df525042c1210f4b101cc05000000000000000000000000000000",
      "30fb81008000c5e1814458750b19f65a02a410acf29effb804e2f5db02df10b7f2c0ffbf04a9f55c032011dcf22400d804000000000000000000000000000000",
      "30fe8100800035e2814858750b81f65c00f80f8df231fe940471f6e6001f1088f2a6fe92044ef6b1015a1092f21fffa004000000000000000000000000000000",
      "3001810080004b03814868750b69f6e6fdad0ffef20efdd40479f678feb40fd9f249fdc40484f6f4fec00fb0f29ffdad04000000000000000000000000000000",
      "30048100800079e47d4858750b17f64cfb5f0f46f46afb430529f6c4fb710ff1f3d4fb300538f64bfc830fbbf315fc1d05000000000000000000000000000000",
      "300781008000a7057e4668750bb1f5d3f9fb0e8ef5ccf96405cdf5fcf90c0f44f52dfa6505e1f52dfa210f29f550fa6305000000000000000000000000000000",
      "30098100800041f67d4668750bcdf4b0f9ab0e21f602f955057ef5adf9d00ee1f559f95f05b1f5d3f9fb0e8ef5ccf96405000000000000000000000000000000",
      "300d810080003d877c4838750b84f458f7dd0c89f6d0f8fc0436f4e2f7620d83f614f8430526f4c0f8a00e71f666f85c05000000000000000000000000000000",
      "30108100800058e77a4668750bf7f2c3f57c0c9cf6abfa0a0470f30ef6790c89f65dfa420414f476f67e0c80f6d0f98a04000000000000000000000000000000",
      "30128100800059f77a4658750b7ef249f5580cd9f69bfaa40389f269f56c0cd1f6a9fab503a3f286f5760cacf6c9faeb03000000000000000000000000000000",
      "3016810080005b177b4868750ba9f298f4450b2cf774fa3102b8f2a5f47a0b24f765fa6e02b8f2b8f4b10b1df755faac02000000000000000000000000000000",
      "30198100800057777a4558750b39f258f4480a80f73efaf40016f26af4940a5ef76bfa37014ef275f4d40a46f780fa8401000000000000000000000000000000",
    ]
  end

  #3)  ZR	R	SR(right)	SL(right)	A	B	X	Y
  #4)  Grip	(none)	Cap	Home	ThumbL	ThumbR	+	-
  #5)  ZL	L	SL(left)	SR(left)	Left	Right	Up	Down
  #6)  analog[0]
  #7)  analog[1]
  #8)  analog[2]
  #9)  analog[3]
  #a)  analog[4]
  #b)  analog[5]
  BYTES_MAP = {
    0 => nil,
    1 => nil,
    2 => nil,
    3 => [:zr, :r, :sr, :sl, :a, :b, :x, :y],
    4 => [:grip, nil, :cap, :home, :thumbl, :thumbr, :plus, :minus],
    5 => [:zl, :l, :sl, :sr, :left, :right, :up, :down],
  },

  # TODO BYTES_MAPから組み立てる
  BUTTONS_MAP = {
    a: { byte_position: 3, bit_position: 3 },
    l: { byte_position: 5, bit_position: 6 },
    r: { byte_position: 3, bit_position: 6 },
    zr: { byte_position: 3, bit_position: 7 },
    zl: { byte_position: 5, bit_position: 7 },
    up: { byte_position: 5, bit_position: 1 },
    down: { byte_position: 5, bit_position: 0 },
    right: { byte_position: 5, bit_position: 2 },
    left: { byte_position: 5, bit_position: 3 },
  }

  @@status = {}
  @@auto_mode_sequence = 0
  @@current_layer = :up
  @@compiled = false

  attr_accessor :binary

  def self.compile!
    return if @@compiled
    BUTTONS_MAP.each do |button, value|
      define_method "pushed_#{button}?" do
        pushed_button?(button)
      end
    end
    @@compiled = true
  end

  # TODO plugin経由で差し込めるようにする
  def self.flip_buttons
    ProconBypassMan::Configuration.instance.layers[@@current_layer].flip_buttons
  end

  def self.auto_mode?
    ProconBypassMan::Configuration.instance.layers[@@current_layer].mode == :auto
  end

  def self.input(binary)
    new(binary)
  end

  def initialize(binary)
    self.class.compile! unless @@compiled
    self.binary = binary.dup
  end

  def status
    @@status
  end

  def next_layer
    case
    when pushed_up?
      :up
    when pushed_right?
      :right
    when pushed_left?
      :left
    when pushed_down?
      :down
    else
      pp "おかしい"
      :up
    end
  end

  def change_layer?
    ProconBypassMan::Configuration.instance.prefix_keys.map { |b| pushed_button?(b) }.all? &&
      (pushed_up? || pushed_right? || pushed_left? || pushed_down?)
  end

  def apply!
    if change_layer?
      @@current_layer = next_layer
      # layer変更中はニュートラルにする
      self.binary = [ProconBypassMan::Procon::Data::NO_ACTION].pack("H*")
      return
    end

    case
    when self.class.auto_mode?
      data = ProconBypassMan::Procon::Data::MEANINGLESS[@@auto_mode_sequence]
      if data.nil?
        @@auto_mode_sequence = 0
        data = ProconBypassMan::Procon::Data::MEANINGLESS[@@auto_mode_sequence]
      end
      @@auto_mode_sequence += 1
      auto_binary = [data].pack("H*")
      self.binary[3] = auto_binary[3]
      self.binary[4] = auto_binary[4]
      self.binary[5] = auto_binary[5]
      self.binary[6] = auto_binary[6]
      self.binary[7] = auto_binary[7]
      self.binary[8] = auto_binary[8]
      self.binary[9] = auto_binary[9]
      self.binary[10] = auto_binary[10]
      self.binary[11] = auto_binary[11]
      return
    else
      flip_buttons.each do |button, options|
        unless options[:if_pushed]
          status[button] = !status[button]
          next
        end

        if (options[:if_pushed] || options[:if_pushed].is_a?(Hash) && options[:if_pushed].all? { |b| pushed_button?(b)}) && pushed_button?(button)
          status[button] = !status[button]
        else
          status[button] = false
        end
      end
    end

    status
  end

  def to_binary
    flip_buttons.each do |button, options|
      # 何もしないで常に連打
      if !options[:if_pushed] && status[button]
        byte_position = BUTTONS_MAP[button][:byte_position]
        value = binary[byte_position].unpack("H*").first.to_i(16) + 2**BUTTONS_MAP[button][:bit_position]
        binary[byte_position] = ["%02X" % value.to_s].pack("H*")
        next
      end


      # 押している時だけ連打
      if (options[:if_pushed] || options[:if_pushed].is_a?(Hash) && options[:if_pushed].is_a?(Hash) && options[:if_pushed].all? { |b| pushed_button?(b) }) && pushed_button?(button) && !status[button]
        byte_position = BUTTONS_MAP[button][:byte_position]
        value = binary[byte_position].unpack("H*").first.to_i(16) - 2**BUTTONS_MAP[button][:bit_position]
        binary[byte_position] = ["%02X" % value.to_s].pack("H*")
      end
    end
    binary
  end

  private

  def pushed_button?(button)
    binary[
      BUTTONS_MAP[button][:byte_position]
    ].unpack("H*").first.to_i(16).to_s(2).reverse[
      BUTTONS_MAP[button][:bit_position]
    ] == '1'
  end

  def flip_buttons
    self.class.flip_buttons
  end
end
