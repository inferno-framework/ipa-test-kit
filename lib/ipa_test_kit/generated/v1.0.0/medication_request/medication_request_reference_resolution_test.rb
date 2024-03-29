require_relative '../../../reference_resolution_test'
require_relative '../resource_list'

module IpaTestKit
  module IpaV100
    class MedicationRequestReferenceResolutionTest < Inferno::Test
      include IpaTestKit::ReferenceResolutionTest
      include ResourceList

      title 'MustSupport references within MedicationRequest resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding IPA profile.

        Elements which may provide external references include:

        * MedicationRequest.encounter
        * MedicationRequest.medication[x]
        * MedicationRequest.reported[x]
        * MedicationRequest.requester
        * MedicationRequest.subject
      )

      id :ipa_v100_medication_request_reference_resolution_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
