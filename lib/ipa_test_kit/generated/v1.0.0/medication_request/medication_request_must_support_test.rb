require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class MedicationRequestMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationRequest resources returned'
      description %(
        Responders conforming to a profile in IPA SHALL return a Must Support
        element if that element is available. This test will look through the
        MedicationRequest resources found previously for the following must
        support elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.dosageInstruction
        * MedicationRequest.dosageInstruction.text
        * MedicationRequest.encounter
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.reported[x]
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject

        Note: Responders who cannot store or return a data element tagged as
        Supported in IPA profiles can still claim conformance to the IPA
        profiles per the IPA conformance resources.
      )

      id :ipa_v100_medication_request_must_support_test

      optional

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
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
