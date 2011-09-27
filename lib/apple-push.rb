require 'base64'
require 'openssl'
require 'socket'
require 'json'

require 'apple-push/version'
require 'apple-push/notification'

module ApplePush

  @host = 'gateway.sandbox.push.apple.com'
  @port = 2195

  class<<self
    attr_accessor :host
    attr_accessor :port
  end

  def self.send_notification(apns_pem, apns_token, message = {})
    connection(apns_pem) do |ssl|
      notification = ApplePush::Notification.new(apns_token, message)
      puts "#{Time.now} [#{host}:#{port}] Device: #{notification.device_token.unpack('H*')} sending #{message.inspect}"
      ssl.write(notification.to_s)
    end
  end

protected

  def self.connection(apns_pem, &block)
    sock         = TCPSocket.new(host.to_s, port.to_i)
    ssl          = OpenSSL::SSL::SSLSocket.new(sock, security_context(apns_pem))
    ssl.connect

    yield(ssl)

    ssl.close
    sock.close

    return true
  end

  def self.security_context(apns_pem)
    pem, password = self.pem_and_password(apns_pem)
    context      = OpenSSL::SSL::SSLContext.new
    context.cert = OpenSSL::X509::Certificate.new(pem)
    context.key  = OpenSSL::PKey::RSA.new(pem, password)
    context.ca_file = File.expand_path(File.join(File.dirname(__FILE__),'../certs/entrust_ssl_ca.cer'))
    context
  end

  def self.pem_and_password(apns_pem)
    if apns_pem.is_a?(Array)
      return self.read_pem(apns_pem.first), apns_pem.last
    else
      return self.read_pem(apns_pem), nil
    end
  end

  def self.read_pem(file_or_string)
    File.exist?(file_or_string) ? File.read(file_or_string) : file_or_string
  end

end
