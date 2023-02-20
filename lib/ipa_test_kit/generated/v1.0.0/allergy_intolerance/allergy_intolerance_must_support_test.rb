require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class AllergyIntoleranceMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the AllergyIntolerance resources returned'
      description %(
        Responders conforming to a profile in IPA SHALL return a Must Support
        element if that element is available. This test will look through the
        AllergyIntolerance resources found previously for the following must
        support elements:

        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.patient
        * AllergyIntolerance.verificationStatus

        Note: Responders who cannot store or return a data element tagged as
        Supported in IPA profiles can still claim conformance to the IPA
        profiles per the IPA conformance resources.
      )

      id :ipa_v100_allergy_intolerance_must_support_test

      optional

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
