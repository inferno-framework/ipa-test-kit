require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class AllergyIntoleranceMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the AllergyIntolerance resources returned'
      description %(
        IPA Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the IPA Core Server Capability
        Statement. This test will look through the AllergyIntolerance resources
        found previously for the following must support elements:

        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.patient
        * AllergyIntolerance.verificationStatus
      )

      id :ipa_v100_allergy_intolerance_must_support_test

      def resource_type
        'AllergyIntolerance'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
