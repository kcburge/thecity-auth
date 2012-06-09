require 'spec_helper'

def signature_for(auth, method, path = "/", query_parms = [], body = "")
  # current unix time in seconds
  verb = method.to_s.upcase
  protocol = 'https://'
  host = 'api.onthecity.org'
  query_parms = query_parms.map { |k,v| "#{k}=#{v}" }.join('')
  query_parms = '?' + query_parms if query_parms.length > 0
  string_to_sign = "#{auth[:timestamp]}#{verb}#{protocol}#{host}#{path}#{query_parms}#{body}"
  unencoded_hmac = OpenSSL::HMAC.digest('sha256', auth[:secret_key], string_to_sign)
  unescaped_hmac = Base64.encode64(unencoded_hmac).chomp
  hmac_signature = CGI.escape(unescaped_hmac)
  hmac_signature
end

describe TheCityAuth::Header do
  it "should handle no path, no query parms" do
    auth = $auth.merge(:timestamp => Time.now.to_i.to_s)
    header = TheCityAuth::Header.new(:get, "https://api.onthecity.org", {}, auth)
    header.signature.should ==(signature_for(auth, :get))
  end

  it "should handle no path, single query parm" do
    auth = $auth.merge(:timestamp => Time.now.to_i.to_s)
    header = TheCityAuth::Header.new(:get, "https://api.onthecity.org/", {:page => 1}, auth)
    header.signature.should ==(signature_for(auth, :get, '/', [['page', '1']]))
  end

  it "should handle path, single query parm" do
    auth = $auth.merge(:timestamp => '1339141434')
    header = TheCityAuth::Header.new(:get, "https://api.onthecity.org/users", {:page => 1}, auth)
    header.signature.should ==(signature_for(auth, :get, '/users', [['page', '1']]))
    puts header.signature
  end

end
