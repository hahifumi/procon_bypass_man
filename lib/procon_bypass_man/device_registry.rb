class ProconBypassMan::DeviceRegistry
  PROCON_PATH = "/dev/hidraw0"
  PROCON2_PATH = "/dev/hidraw1"

  def gadget
    @gadget
  end

  def procon
    @procon
  end

  def initialize
    init_devices
  end

  # @return [void]
  def init_devices
    loop do
      case
      when File.exist?(PROCON_PATH)
        system('echo > /sys/kernel/config/usb_gadget/procon/UDC')
        system('ls /sys/class/udc > /sys/kernel/config/usb_gadget/procon/UDC')
        sleep 0.5
        @gadget = File.open('/dev/hidg0', "w+")
        @procon = File.open(PROCON_PATH, "w+")
        break
      when File.exist?(PROCON2_PATH)
        system('echo > /sys/kernel/config/usb_gadget/procon/UDC')
        system('ls /sys/class/udc > /sys/kernel/config/usb_gadget/procon/UDC')
        sleep 0.5
        @gadget = File.open('/dev/hidg0', "w+")
        @procon = File.open(PROCON2_PATH, "w+")
        break
      else
        puts "プロコンをラズベイに挿してください"
        sleep(1)
      end
    end
  end
end
