require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class OxygenSatPatientCategoryDateSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for Observation search by patient + category + date'
    description %(
A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_oxygensat_patient_category_date_search_test
    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'Observation',
        search_param_names: ['patient', 'category', 'date'],
        possible_status_search: true,
        token_search_params: ['category'],
        params_with_comparators: ['date']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:oxygensat_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
