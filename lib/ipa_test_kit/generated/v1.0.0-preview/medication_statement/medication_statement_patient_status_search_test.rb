require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module IpaTestKit
  module IpaV100PREVIEW
    class MedicationStatementPatientStatusSearchTest < Inferno::Test
      include IpaTestKit::SearchTest

      title 'Server returns valid results for MedicationStatement search by patient + status'
      description %(
A server SHOULD support searching by
patient + status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

# TODO: Fix this
# [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)


      )

      id :ipa_v100preview_medication_statement_patient_status_search_test
      optional
  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationStatement',
        search_param_names: ['patient', 'status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
