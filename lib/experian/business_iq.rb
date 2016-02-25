require 'experian/business_iq/client'
require 'experian/business_iq/request'
require 'experian/business_iq/profile_request'
require 'experian/business_iq/similars_request'
require 'experian/business_iq/response'

module Experian
  module BusinessIq
    DB_HOST = "BISPROD"
    DB_HOST_TEST = "BISTESTP"

    DEFAULT_PROFILE_REQUEST = "BusinessProfile"

    def self.db_host
      Experian.test_mode? ? DB_HOST_TEST : DB_HOST
    end

    def self.get_profile(options = {})
      Client.new.get_profile(options)
    end

    def self.get_business_profile(options = {})
      Client.new.get_business_profile(options)
    end

    def self.get_premier_profile(options = {})
      Client.new.get_premier_profile(options)
    end

    def self.get_list_of_similars(options = {})
      Client.new.get_list_of_similars(options)
    end

  end
end
