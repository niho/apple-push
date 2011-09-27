ApplePush
=========

ApplePush is a very simple implementation of the APNS (Apple Push Notification
Service) protocol. It differs from the
[APNS gem](https://github.com/jpoz/APNS) by being able to push to different
iOS apps from the same Ruby application.

Setup
-----

    $ gem install apple-push

    require 'apple-push'
    ApplePush.host = 'gateway.push.apple.com' 
    ApplePush.port = 2195

Creating a PEM certificate
--------------------------

In Keychain access export your certificate as a p12. Then run the following command to convert it to a .pem

    openssl pkcs12 -in cert.p12 -out cert.pem -nodes -clcerts

Then store the PEM data in your database or in a file.

Example usage
-------------

    ApplePush.send_notification(pem, device_token, 'Hello, world!')
    ApplePush.send_notification(pem, device_token, :alert => 'Hello, world!', :badge => 1, :sound => 'default')
    ApplePush.send_notification(pem, device_token, :alert => 'Hello, world!', :badge => 1, :sound => 'default', :other => { :foo => 'bar' })

The `pem` parameter can either be the path to a .pem file or the PEM data it
self, retrieved from a database for example. If the PEM certificate is
encrypted with a password you should pass an array with the pem and the
password instead of just the pem.

The `device_token` can either be binary data, or Base64 encoded.

Author
------

Created by Niklas Holmgren (niklas@sutajio.se) and released under
the MIT license.
