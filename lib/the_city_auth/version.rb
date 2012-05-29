module TheCityAuth
  module Version
    MAJOR = 0 unless defined? ::TheCityAuth::Version::MAJOR
    MINOR = 1 unless defined? ::TheCityAuth::Version::MINOR
    PATCH = 0 unless defined? ::TheCityAuth::Version::PATCH
    STRING = [MAJOR, MINOR, PATCH].join('.') unless defined? ::TheCityAuth::Version::STRING
  end
end
