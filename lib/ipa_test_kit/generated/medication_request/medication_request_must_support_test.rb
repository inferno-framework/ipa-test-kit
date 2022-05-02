require_relative '../../must_support_test'

module IpaTestKit
  class MedicationRequestMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the MedicationRequest resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the MedicationRequest resources
      found previously for the following must support elements:

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
    )

    id :ipa_010_medication_request_must_support_test

    def resource_type
      'MedicationRequest'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:medication_request_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
