module ApplePush
  class Notification
    attr_accessor :device_token, :alert, :badge, :sound, :other

    def initialize(device_token, message)
      if device_token
        self.device_token = device_token
      else
        raise "Invalid device token"
      end
      if message.is_a?(Hash)
        self.alert = message[:alert]
        self.badge = message[:badge]
        self.sound = message[:sound]
        self.other = message[:other]
      elsif message.is_a?(String)
        self.alert = message
      else
        raise "Notification message needs to be either a hash or a string"
      end
    end

    def device_token
      if @device_token =~ /=$/
        Base64.decode64(@device_token)
      else
        @device_token
      end
    end

    def to_s
      dt = self.device_token
      pl = self.payload
      [0, 0, dt.size, dt, 0, pl.size, pl].pack("ccca*cca*")
    end

  protected

    def payload
      aps = {'aps'=> {} }
      aps['aps']['alert'] = self.alert if self.alert
      aps['aps']['badge'] = self.badge if self.badge
      aps['aps']['sound'] = self.sound if self.sound
      aps.merge!(self.other) if self.other
      aps.to_json
    end
    
  end
end