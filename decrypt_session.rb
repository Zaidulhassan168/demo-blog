require 'rubygems'
require 'cgi'
require 'active_support'

def decrypt_session_cookie(cookie, key)
  cookie = CGI::unescape(cookie)
  
  # Default values for Rails 4 apps
  key_iter_num = 1000
  key_size     = 64
  salt         = "encrypted cookie"         
  signed_salt  = "signed encrypted cookie"  

  key_generator = ActiveSupport::KeyGenerator.new(key, iterations: key_iter_num)
  secret = key_generator.generate_key(salt)
  sign_secret = key_generator.generate_key(signed_salt)

  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
  puts encryptor.decrypt_and_verify(cookie)
end


# Time to test ... (With data from Arbeit327)
key= "682a8a3f0e5133fb4ed5e38db8bfad6c3561d76a1eb760db34f6f11ae02e989b2e6e3829b89d8af1061b645a5b2d7c934e096c8f96fffb88ffe05b4819d70273"
cookie= 'jdDE0gFWSwM8AQqNZeZChZX4JMCRKyXmVPvRirgoSf0fY64Lqubzgh0IYH1i5Ts%2FmlRxG%2F0q%2FclBfwG92VrV%2BJwE1YTWQHPbEotufDHiEZjXaHEm8SbojcGQgmrqDA3hqPSG8mJdeUEVT4o9bMkdKNLyd3bO36TvUy9qmKL0yj191uFr4MilctAFGK21cBrw%2Bpu7wjr%2BwKxsABSTHMWGHQqw2CMHuRuwf7jX9Lq1sSAI7sRJrs%2FFZrmvrz4oWt2IoCUyom%2FqyQh3dXVhyi8vLSWAWop5i%2FKg0ovdT37yZXfz76CaLiP9Znxw%2FloJSML6IYS2iNuiBbJw8eNbIsY6Muc2QOVVma8Ux1NEHj%2BUsiRLc37UPI%2B4CY6cOS97fz%2FlPo6VuyADEqXRFwvo1vo%3D--dZjjXoPb7gqfpbEe--JAgokSOVvWpZ9MH8Gm1TDQ%3D%3D'

decrypt_session_cookie(cookie, key)


