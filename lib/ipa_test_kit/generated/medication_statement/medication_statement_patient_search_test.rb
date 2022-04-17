require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class MedicationStatementPatientSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for MedicationStatement search by patient'
    description %(
A server SHALL support searching by
patient on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationStatement resources use external references to
Medications, the search will be repeated with
`_include=MedicationStatement:medication`.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. IPA
requires that both forms are supported by IPA responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of IPA v0.1.0.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_medication_statement_patient_search_test
    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        first_search: true,
        fixed_value_search: false,
        resource_type: 'MedicationStatement',
        search_param_names: ['patient'],
        saves_delayed_references: true,
        possible_status_search: true,
        test_medication_inclusion_ms: true,
        test_reference_variants: true,
        multiple_or_search_params: [],
        test_post_search: true
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
