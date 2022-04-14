require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class MedicationStatementPatientContextSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for MedicationStatement search by patient + context'
    description %(
A server SHOULD support searching by
patient + context on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationStatement resources use external references to
Medications, the search will be repeated with
`_include=MedicationStatement:medication`.

[IPA Server CapabilityStatement](http://hl7.org/fhir/uv/ipa/STU3.1.1/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_medication_statement_patient_context_search_test
    optional

    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'MedicationStatement',
        search_param_names: ['patient', 'context'],
        possible_status_search: true,
        test_medication_inclusion: true
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
