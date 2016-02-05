require 'experian/business_iq/client'
require 'experian/business_iq/request'
require 'experian/business_iq/premier_request'
require 'experian/business_iq/similars_request'
require 'experian/business_iq/response'

module Experian
  module BusinessIq
    DB_HOST = "BISPROD"
    DB_HOST_TEST = "BISTESTP"

    def self.db_host
      Experian.test_mode? ? DB_HOST_TEST : DB_HOST
    end

    def self.get_premier_profile(options = {})
      Client.new.get_premier_profile(options)
    end

    def self.get_list_of_similars(options = {})
      Client.new.get_list_of_similars(options)
    end

    # # convenience method
    # def self.check_id(options = {})
    #   Client.new.check_id(options)
    # end
    #
    # def self.request_questions(options = {})
    #   Client.new.request_questions(options)
    # end
    #
    # def self.send_answers(options = {})
    #   Client.new.send_answers(options)
    # end

  end
end
