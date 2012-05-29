require 'openssl'
require 'base64'
require 'cgi'

module TheCityAuth
  class Header
    def self.default_options
      {
        :timestamp => Time.now.to_i.to_s
      }
    end

    def self.encode(value)
      URI.encode(value.to_s, /[^a-z0-9\-\.\_\~]/i)
    end

    attr_reader :method, :params, :options

    def initialize(method, url, params, auth = {})
      @method = method.to_s.upcase
      case url
      when URI
        @uri = url
      else
        @uri = URI.parse(url).tap do |uri|
          uri.scheme = uri.scheme.downcase
          uri.normalize!
          uri.fragment = nil
        end
      end
      @params = params
      @options = self.class.default_options.merge(auth)
    end

    def url
      @uri.dup.tap{|u| u.query = nil }.to_s
    end

    def to_hash
      # Uncomment the below if you want to what is being signed.
      # puts signature_base 
      {
        'X-City-Sig'        => signature,
        'X-City-User-Token' => user_token,
        'X-City-Time'       => options[:timestamp],
      }
    end

    def signature
      self.class.encode(hmac_signature)
    end

    private

    def hmac_signature
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, secret, signature_base)).chomp.gsub(/\n/, '')
    end

    def secret
      self.class.encode(options[:secret_key])
    end
    alias_method :plaintext_signature, :secret

    def signature_base
      [options[:timestamp], method, url, normalized_params].join('')
    end

    def normalized_params
      result = signature_params.map {|k,v| "#{k}=#{self.class.encode(v)}" }.join('&')
      if result.length > 0
        result = '?' + result
      end
      result
    end

    def signature_params
      params.to_a + url_params
    end

    def url_params
      CGI.parse(@uri.query || '').inject([]){|p,(k,vs)| p + vs.map{|v| [k, v] } }
    end

    def user_token
      options[:user_token]
    end
  end
end
