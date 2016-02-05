module Experian
  module BusinessIq
    class Client < Experian::Client

      def get_premier_profile(options = {})
        assert_check_options(options)

        puts PremierRequest.new(options).xml

        Response.new(submit_request(PremierRequest.new(options)).body)
      end

      def get_list_of_similars(options = {})
        assert_check_options(options)

        puts SimilarsRequest.new(options).xml

        Response.new(submit_request(SimilarsRequest.new(options)).body)
      end

      def assert_check_options(options)
        # return if options[:first_name] && options[:last_name] && options[:ssn]
        # return if options[:first_name] && options[:last_name] && options[:street] && options[:zip]
        # raise Experian::ArgumentError, "Required options missing: first_name, last_name, ssn OR first_name, last_name, street, zip"
      end

    end
  end
end