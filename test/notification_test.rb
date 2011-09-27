require File.expand_path('test/test_helper')

class NotificationTest < Test::Unit::TestCase

  def setup
    @notification = ApplePush::Notification.new('FkjWc8HztEiEblJ7g1n8AKw8kvyCtkQKc10tmoo2Tak=',
      :alert => 'Hello, world!', :badge => 1, :sound => 'default', :other => { :foo => 'bar' })
  end

  def test_raises_errors
    assert_raises RuntimeError do
      ApplePush::Notification.new(nil, 'Hello, world!')
    end
    assert_raises RuntimeError do
      ApplePush::Notification.new('...', nil)
    end
  end

  def test_can_create_notification_with_only_an_alert_string
    assert_equal 'Hello, world!', ApplePush::Notification.new('...', 'Hello, world!').alert
  end

  def test_can_handle_base64_encoded_device_token
    @notification.device_token = 'FkjWc8HztEiEblJ7g1n8AKw8kvyCtkQKc10tmoo2Tak='
    assert_equal Base64.decode64('FkjWc8HztEiEblJ7g1n8AKw8kvyCtkQKc10tmoo2Tak='), @notification.device_token
  end

  def test_can_handle_binary_device_token
    @notification.device_token = Base64.decode64('FkjWc8HztEiEblJ7g1n8AKw8kvyCtkQKc10tmoo2Tak=')
    assert_equal Base64.decode64('FkjWc8HztEiEblJ7g1n8AKw8kvyCtkQKc10tmoo2Tak='), @notification.device_token
  end

  def test_payload
    payload = JSON.parse(@notification.send(:payload))
    assert_equal 'Hello, world!', payload['aps']['alert']
    assert_equal 1, payload['aps']['badge']
    assert_equal 'default', payload['aps']['sound']
    assert_equal 'bar', payload['foo']
  end

  def test_packaged_notification
    assert_equal "\x00\x00 \x16H\xD6s\xC1\xF3\xB4H\x84nR{\x83Y\xFC\x00\xAC<\x92\xFC\x82\xB6D\ns]-\x9A\x8A6M\xA9\x00I{\"aps\":{\"alert\":\"Hello, world!\",\"badge\":1,\"sound\":\"default\"},\"foo\":\"bar\"}", @notification.to_s
  end

end
