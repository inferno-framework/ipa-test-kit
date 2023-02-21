require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module IpaTestKit
  module IpaV100
    class DocumentReferencePatientTypePeriodSearchTest < Inferno::Test
      include IpaTestKit::SearchTest

      title 'Server returns valid results for DocumentReference search by patient + type + period'
      description %(
A server SHOULD support searching by
patient + type + period on the DocumentReference resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

# TODO: Fix this
# [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)


      )

      id :ipa_v100_document_reference_patient_type_period_search_test
      optional
  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'DocumentReference',
        search_param_names: ['patient', 'type', 'period']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:document_reference_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
