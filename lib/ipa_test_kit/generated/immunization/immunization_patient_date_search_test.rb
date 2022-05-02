require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class ImmunizationPatientDateSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for Immunization search by patient + date'
    description %(
A server SHOULD support searching by
patient + date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_immunization_patient_date_search_test
    optional

    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'Immunization',
        search_param_names: ['patient', 'date'],
        possible_status_search: true,
        params_with_comparators: ['date']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:immunization_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
