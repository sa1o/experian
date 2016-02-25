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

    end
  end
end
