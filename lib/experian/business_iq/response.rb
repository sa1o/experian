module Experian
  module BusinessIq
    class Response < Experian::Response

      def terms?
        # TODO: Check the response for a terms message (the first request of the day)
        false
      end

      #
      # Is the response a list of similars?
      #
      def similars?
        (@response['Products']['PremierProfile']['BusinessNameAndAddress']['ProfileType'] == 'List of Similars') rescue false
      end

      #
      # Codes used to make another request if similars is found
      #
      def get_similars_codes
        if self.similars?
          transaction_number = @response['Products']['PremierProfile']['InputSummary']['InquiryTransactionNumber']
          experian_file_number = @response['Products']['PremierProfile']['ListOfSimilars']['ExperianFileNumber']
          record_sequence_number = @response['Products']['PremierProfile']['ListOfSimilars']['RecordSequenceNumber']

          {
            transaction_number: transaction_number,
            experian_file_number: experian_file_number,
            record_sequence_number: record_sequence_number,
            bis_list_number: "#{experian_file_number}#{record_sequence_number}"
          }
        end
      end

    end
  end
end
