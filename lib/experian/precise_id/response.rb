module Experian
  module PreciseId
    class Response < Experian::Response
      def success?
        has_precise_id_section? && !error?
      end

      def error?
        !has_precise_id_section? || has_error_section?
      end

      def error_code
        has_error_section? ? error_section['ErrorCode'] : nil
      end

      def error_message
        if has_error_section?
          error_message = error_section['ErrorDescription']
        else
          error_message = nil
        end

        super || error_message
      end

      def session_id
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'SessionID')
      end

      def fpd_score
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'Summary', 'Scores', 'FPDScore')
      end

      def score
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'Summary', 'Scores', 'PreciseIDScore')
      end

      def match_score
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'PreciseMatch', 'PreciseMatchScore')
      end

      def initial_decision
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'Summary', 'InitialDecision')
      end

      def final_decision
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'Summary', 'FinalDecision')
      end

      def ssn
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer',
          'PreciseMatch', 'SSNFinder', 'Detail', 'SSNFinderRcd', 'SSNOnFile')
      end

      def accept_refer_code
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'KBAScore', 'ScoreSummary', 'AcceptReferCode')
      end

      def kbas_result_code
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'KBAScore', 'General', 'KBAResultCode')
      end

      def kbas_result_code_description
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'KBAScore', 'General', 'KBAResultCodeDescription')
      end

      def questions
        questions = hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'KBA', 'QuestionSet')
        if questions
          questions.collect do |question|
            {
              type: question['QuestionType'].to_i,
              text: question['QuestionText'],
              choices: question['QuestionSelect']['QuestionChoice']
            }
          end
        else
          []
        end
      end

      private

      def has_precise_id_section?
        !!precise_id_server_section
      end

      def precise_id_server_section
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer')
      end

      def has_error_section?
        !!error_section
      end

      def error_section
        hash_path(@response, 'FraudSolutions', 'Response', 'Products', 'PreciseIDServer', 'Error')
      end

      def hash_path(hash, *path)
        field = path[0]
        if path.length == 1
          hash[field]
        else
          if hash[field]
            hash_path(hash[field], *path[1..-1])
          else
            nil
          end
        end
      end
    end
  end
end
