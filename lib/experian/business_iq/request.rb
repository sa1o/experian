module Experian
  module BusinessIq
    class Request < Experian::Request

      def build_request
        super do |xml|
          xml.tag!('EAI', Experian.eai)
          xml.tag!('DBHost', BusinessIq.db_host)
          add_reference_id(xml)
          xml.tag!('Request', :xmlns => Experian::XML_REQUEST_NAMESPACE, :version => '1.0') do
            xml.tag!('Products') do
              add_request_content(xml)
            end
          end
        end
      end

      def add_reference_id(xml)
        xml.tag!('ReferenceId', @options[:reference_id]) if @options[:reference_id]
      end

      def add_subscriber(xml)
        xml.tag!('Subscriber') do
          # xml.tag!('Preamble', Experian.preamble)
          xml.tag!('OpInitials', Experian.op_initials)
          xml.tag!('SubCode', Experian.subcode)
        end
      end

      def add_output_type(xml)
        xml.tag!('OutputType') do
          xml.tag!('XML') do
            xml.tag!('Verbose', 'Y')
          end
        end
      end

      def add_vendor(xml)
        xml.tag!('Vendor') do
          xml.tag!('VendorNumber', Experian.vendor_number)
        end
      end

      def add_request_content(xml)
        raise "sub classes must override this method"
      end


        # def build_request
        #   super do |xml|
        #     xml.tag!('EAI', Experian.eai)
        #     xml.tag!('DBHost', BusinessIq.db_host)
        #     add_reference_id(xml)
        #     xml.tag!('Request', :xmlns => Experian::XML_REQUEST_NAMESPACE, :version => '1.0') do
        #       xml.tag!('Products') do
        #         xml.tag!('PremierProfile') do
        #           add_subscriber(xml)
        #
        #           add_business_applicant(xml)
        #           add_business_owner(xml)
        #
        #           add_output_type(xml)
        #           add_vendor(xml)
        #           add_options(xml)
        #         end
        #       end
        #     end
        #   end
        # end
        #
        # def add_reference_id(xml)
        #   xml.tag!('ReferenceId', @options[:reference_id]) if @options[:reference_id]
        # end
        #
        # def add_subscriber(xml)
        #   xml.tag!('Subscriber') do
        #     xml.tag!('Preamble', Experian.preamble)
        #     xml.tag!('OpInitials', Experian.op_initials)
        #     xml.tag!('SubCode', Experian.subcode)
        #   end
        # end
        #
        # def add_business_applicant(xml)
        #   xml.tag!('BusinessApplicant') do
        #     xml.tag!('BusinessName', @options[:business_name])
        #     xml.tag!('AlternateName', @options[:alternate_name] || @options[:business_name])
        #     xml.tag!('TaxId', @options[:tax_id]) if @options[:tax_id]
        #     xml.tag!('CurrentAddress') do
        #       xml.tag!('Street', @options[:street])
        #       xml.tag!('City', @options[:city])
        #       xml.tag!('State', @options[:state])
        #       xml.tag!('Zip', @options[:zip])
        #     end
        #     xml.tag!('AlternateAddress') do
        #       xml.tag!('Street', @options[:alt_street] || @options[:street])
        #       xml.tag!('City', @options[:alt_city] || @options[:city])
        #       xml.tag!('State', @options[:alt_state] || @options[:state])
        #       xml.tag!('Zip', @options[:alt_zip] || @options[:zip])
        #     end
        #   end
        # end
        #
        # def add_business_owner(xml)
        #   xml.tag!('BusinessOwner') do
        #     xml.tag!('OwnerName') do
        #       xml.tag!('Surname', @options[:business_owner][:last_name])
        #       xml.tag!('First', @options[:business_owner][:first_name])
        #       xml.tag!('Middle', @options[:business_owner][:middle_name]) if @options[:business_owner][:middle_name]
        #       xml.tag!('Gen', @options[:business_owner][:generation_code]) if @options[:business_owner][:generation_code]
        #     end
        #     xml.tag!('SSN', @options[:business_owner][:ssn]) if @options[:business_owner][:ssn]
        #     xml.tag!('DOB', @options[:business_owner][:dob]) if @options[:business_owner][:dob]
        #     xml.tag!('CurrentAddress') do
        #       xml.tag!('Street', @options[:business_owner][:street])
        #       xml.tag!('City', @options[:business_owner][:city])
        #       xml.tag!('State', @options[:business_owner][:state])
        #       xml.tag!('Zip', @options[:business_owner][:zip])
        #     end
        #   end if @options[:business_owner]
        # end
        #
        # # def add_applicant(xml)
        # #   xml.tag!('PrimaryApplicant') do
        # #     xml.tag!('Name') do
        # #       xml.tag!('Surname', @options[:last_name])
        # #       xml.tag!('First', @options[:first_name])
        # #       xml.tag!('Middle', @options[:middle_name]) if @options[:middle_name]
        # #       xml.tag!('Gen', @options[:generation_code]) if @options[:generation_code]
        # #     end
        # #     xml.tag!('SSN', @options[:ssn]) if @options[:ssn]
        # #     add_current_address(xml)
        # #     add_previous_address(xml)
        # #     add_driver_license(xml)
        # #     add_employment(xml)
        # #     xml.tag!('Age', @options[:age]) if @options[:age]
        # #     xml.tag!('DOB', @options[:dob]) if @options[:dob]
        # #     xml.tag!('YOB', @options[:yob]) if @options[:yob]
        # #   end
        # # end
        # #
        # # def add_current_address(xml)
        # #   xml.tag!('CurrentAddress') do
        # #     xml.tag!('Street', @options[:street])
        # #     xml.tag!('City', @options[:city])
        # #     xml.tag!('State', @options[:state])
        # #     xml.tag!('Zip', @options[:zip])
        # #   end if @options[:zip]
        # # end
        # #
        # # def add_previous_address(xml)
        # #   xml.tag!('PreviousAddress') do
        # #     xml.tag!('Street', @options[:previous_street])
        # #     xml.tag!('City', @options[:previous_city])
        # #     xml.tag!('State', @options[:previous_state])
        # #     xml.tag!('Zip', @options[:previous_zip])
        # #   end if @options[:previous_zip]
        # # end
        # #
        # # def add_driver_license(xml)
        # #   xml.tag!('DriverLicense') do
        # #     xml.tag!('State', @options[:driver_license_state])
        # #     xml.tag!('Number', @options[:driver_license_number])
        # #   end if @options[:driver_license_number]
        # # end
        # #
        # # def add_employment(xml)
        # #   # Not Implemented
        # # end
        # #
        # # def add_account_type(xml)
        # #   xml.tag!('AccountType') do
        # #     xml.tag!('Type', @options[:account_type])
        # #     xml.tag!('Terms', @options[:account_terms])
        # #     xml.tag!('FullAmount', @options[:account_full_amount])
        # #     xml.tag!('AbbreviatedAmount', @options[:account_abbreviated_amount])
        # #   end if @options[:account_type]
        # # end
        #
        #
        # def add_output_type(xml)
        #   xml.tag!('OutputType') do
        #     xml.tag!('XML') do
        #       xml.tag!('Verbose', 'Y')
        #     end
        #   end
        # end
        #
        # def add_vendor(xml)
        #   xml.tag!('Vendor') do
        #     xml.tag!('VendorNumber', Experian.vendor_number)
        #   end
        # end
        #
        # def add_options(xml)
        #   # xml.tag!('Options') do
        #   # xml.tag!('ReferenceNumber', @options[:reference_number])
        #   # xml.tag!('EndUser', @options[:end_user])
        #   # xml.tag!('CustomerName', 'StandAlone BOP TEST')
        #   # end
        # end

    end
  end
end
