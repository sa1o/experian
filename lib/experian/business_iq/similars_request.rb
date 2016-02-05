module Experian
  module BusinessIq
    class SimilarsRequest < Request

      def add_request_content(xml)
        xml.tag!('ListOfSimilars') do
          add_subscriber(xml)
          add_business_applicant(xml)
          add_addons(xml)
          add_output_type(xml)
          add_vendor(xml)
        end
      end

      private

      def add_business_applicant(xml)
        xml.tag!('BusinessApplicant') do
          xml.tag!('TransactionNumber', @options[:transaction_number])
          xml.tag!('BISListNumber', @options[:bis_list_number])
        end
      end

      def add_addons(xml)
        xml.tag!('AddOns') do
          xml.tag!('BUSP', 'Y')
        end
      end

    end
  end
end
