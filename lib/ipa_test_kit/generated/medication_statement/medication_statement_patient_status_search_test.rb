require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class MedicationStatementPatientStatusSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for MedicationStatement search by patient + status'
    description %(
A server SHALL support searching by
patient + status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationStatement resources use external references to
Medications, the search will be repeated with
`_include=MedicationStatement:medication`.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_medication_statement_patient_status_search_test
    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'MedicationStatement',
        search_param_names: ['patient', 'status'],
        test_medication_inclusion_ms: true,
        multiple_or_search_params: ['status']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:medication_statement_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
