require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class MedicationRequestPatientIntentEncounterSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for MedicationRequest search by patient + intent + encounter'
    description %(
A server SHOULD support searching by
patient + intent + encounter on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_medication_request_patient_intent_encounter_search_test
    optional

    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'MedicationRequest',
        search_param_names: ['patient', 'intent', 'encounter'],
        possible_status_search: true,
        test_medication_inclusion_mr: true,
        multiple_or_search_params: ['intent']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:medication_request_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
