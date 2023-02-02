require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module IpaTestKit
  module IpaV100PREVIEW
    class AllergyIntolerancePatientClinicalStatusSearchTest < Inferno::Test
      include IpaTestKit::SearchTest

      title 'Server returns valid results for AllergyIntolerance search by patient + clinical-status'
      description %(
A server SHOULD support searching by
patient + clinical-status on the AllergyIntolerance resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

# TODO: Fix this
# [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)


      )

      id :ipa_v100preview_allergy_intolerance_patient_clinical_status_search_test
      optional
  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'AllergyIntolerance',
        search_param_names: ['patient', 'clinical-status'],
        token_search_params: ['clinical-status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
