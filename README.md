thecity-auth
============
Simple library to build The City API headers.

Example Usage:
---

  require 'the_city_auth'

  auth = {
    :secret_key => '123456789abcdef0123456789abcdef012345678',
    :user_token => '123456789abcdef0'
  }

  TheCityAuth::Header.new(:get, "https://api.onthecity.org/users", { :page => 1 }, auth).to_hash

This will create the following hash:

  {
    "X-City-Sig"        => "6JkIf4v8J5pk08mf4t0dYV3jjVAgITdmzL%2BQf3qan%2Fc%3D",
    "X-City-User-Token" => "123456789abcdef0",
    "X-City-Time"       => "1338308721"
  }

Copyright
---------
Copyright (c) 2012 Kevin Burge.
See [LICENSE](https://github.com/kcburge/thecity-auth/blob/master/LICENSE.md) for details.
