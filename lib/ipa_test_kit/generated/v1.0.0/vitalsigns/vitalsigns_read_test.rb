require_relative '../../../read_test'

module IpaTestKit
  module IpaV100
    class VitalsignsReadTest < Inferno::Test
      include IpaTestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :ipa_v100_vitalsigns_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:vitalsigns_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
