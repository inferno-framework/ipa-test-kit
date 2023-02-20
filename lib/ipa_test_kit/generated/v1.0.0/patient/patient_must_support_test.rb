require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class PatientMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        Responders conforming to a profile in IPA SHALL return a Must Support
        element if that element is available. This test will look through the
        Patient resources found previously for the following must
        support elements:

        * Patient.active
        * Patient.birthDate
        * Patient.gender
        * Patient.identifier
        * Patient.identifier.value
        * Patient.link
        * Patient.name

        Note: Responders who cannot store or return a data element tagged as
        Supported in IPA profiles can still claim conformance to the IPA
        profiles per the IPA conformance resources.
      )

      id :ipa_v100_patient_must_support_test

      optional

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
