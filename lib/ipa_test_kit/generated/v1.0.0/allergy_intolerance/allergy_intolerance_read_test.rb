require_relative '../../../read_test'

module IpaTestKit
  module IpaV100PREVIEW
    class AllergyIntoleranceReadTest < Inferno::Test
      include IpaTestKit::ReadTest

      title 'Server returns correct AllergyIntolerance resource from AllergyIntolerance read interaction'
      description 'A server SHALL support the AllergyIntolerance read interaction.'

      id :ipa_v100preview_allergy_intolerance_read_test

      def resource_type
        'AllergyIntolerance'
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
