require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module IpaTestKit
  module IpaV100PREVIEW
    class PatientGenderSearchTest < Inferno::Test
      include IpaTestKit::SearchTest

      title 'Server returns valid results for Patient search by gender'
      description %(
A server SHOULD support searching by
gender on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :ipa_v100preview_patient_gender_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Patient',
        search_param_names: ['gender']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end