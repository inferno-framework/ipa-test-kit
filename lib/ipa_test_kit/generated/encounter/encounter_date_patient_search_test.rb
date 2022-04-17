require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class EncounterDatePatientSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for Encounter search by date + patient'
    description %(
A server SHALL support searching by
date + patient on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_encounter_date_patient_search_test
    input :patient_ids,
      title: 'Patient IDs',
      description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'Encounter',
        search_param_names: ['date', 'patient'],
        possible_status_search: true,
        params_with_comparators: ['date']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:encounter_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
