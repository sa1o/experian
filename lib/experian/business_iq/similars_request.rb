module Experian
  module BusinessIq
    class SimilarsRequest < Request

      def add_request_content(xml)
        xml.tag!('ListOfSimilars') do
          add_subscriber(xml)
          add_business_applicant(xml)
          add_business_owner(xml)
          add_addons(xml)
          add_output_type(xml)
          add_vendor(xml)
          add_options(xml)
        end
      end

      private

      def add_business_applicant(xml)
        xml.tag!('BusinessApplicant') do
          xml.tag!('TransactionNumber', @options[:transaction_number])
          xml.tag!('BISListNumber', @options[:bis_list_number])
        end
      end

      def add_business_owner(xml)
        if @options[:business_owner]
          xml.tag!('BusinessOwner') do
            xml.tag!('OwnerName') do
              xml.tag!('Surname', @options[:business_owner][:last_name])
              xml.tag!('First', @options[:business_owner][:first_name])
              xml.tag!('Middle', @options[:business_owner][:middle_name]) if @options[:business_owner][:middle_name]
              xml.tag!('Gen', @options[:business_owner][:generation_code]) if @options[:business_owner][:generation_code]
            end
            xml.tag!('SSN', @options[:business_owner][:ssn]) if @options[:business_owner][:ssn]
            xml.tag!('DOB', @options[:business_owner][:dob]) if @options[:business_owner][:dob]

            if @options[:business_owner][:street] and @options[:business_owner][:city] and @options[:business_owner][:state] and @options[:business_owner][:zip]
              xml.tag!('CurrentAddress') do
                xml.tag!('Street', @options[:business_owner][:street])
                xml.tag!('City', @options[:business_owner][:city])
                xml.tag!('State', @options[:business_owner][:state])
                xml.tag!('Zip', @options[:business_owner][:zip])
              end
            end
          end
        end
      end

      def add_addons(xml)
        if @options[:addons]
          xml.tag!('AddOns') do
            xml.tag!('BUSP', 'Y') if @options[:addons][:busp]
            xml.tag!('BOP', 'Y') if @options[:addons][:bop]
            xml.tag!('RiskModelCode', @options[:addons][:risk_model_code]) if @options[:addons][:risk_model_code]
          end
        end
      end

      def add_options(xml)
        if @options[:options]
          xml.tag!('Options') do
            xml.tag!('CustomerName', @options[:options][:customer_name]) if @options[:options][:customer_name]
          end
        end
      end

    end
  end
end
