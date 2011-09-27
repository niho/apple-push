require File.expand_path('test/test_helper')

class ApplePushTest < Test::Unit::TestCase

  def test_can_push_notification
    pem = File.read('test/cert.pem')
    device_token = 'gM/RJodgEmAI////WGWMs/QjbFq05pyQ8hCVsTTDeiI='
    assert ApplePush.send_notification(pem, device_token, 'Hello, world!')
    assert ApplePush.send_notification(pem, device_token, :alert => 'Hello, world!', :badge => 1)
  end

  def test_can_create_security_context_from_file
    assert ApplePush.security_context('test/cert.pem')
  end

  def test_can_create_security_context_from_string
    assert ApplePush.security_context(File.read('test/cert.pem'))
  end

  def test_can_create_security_context_from_file_with_password
    assert ApplePush.security_context(['test/cert_secure.pem', '123456'])
  end

  def test_can_create_security_context_from_string_with_password
    assert ApplePush.security_context([File.read('test/cert_secure.pem'), '123456'])
  end

end
