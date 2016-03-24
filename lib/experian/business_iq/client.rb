module Experian
  module BusinessIq
    class Client < Experian::Client

      def get_profile(options = {})
        assert_check_options(options)
        submit_request(ProfileRequest.new(options))
      end

      def get_business_profile(options = {})
        options[:request_type] = :business
        assert_check_options(options)
        submit_request(ProfileRequest.new(options))
      end

      def get_premier_profile(options = {})
        options[:request_type] = :premier
        assert_check_options(options)
        submit_request(ProfileRequest.new(options))
      end

      def get_list_of_similars(options = {})
        assert_check_options(options)
        submit_request(SimilarsRequest.new(options))
      end

      private

      def submit_request(request)
        raw_response = super
        response = Response.new(raw_response.body)
        check_response(response, raw_response)
        [request, response]
      end

      def check_response(response, raw_response)
        if Experian.logger && response.error? && (response.error_code.nil? && response.error_message.nil?)
          Experian.logger.debug "Unknown Experian Error Detected, Raw response: #{raw_response.inspect}"
        end
      end

      def assert_check_options(options)
        # TODO
      end

    end
  end
end