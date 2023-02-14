require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class PatientMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        IPA Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the IPA Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.active
        * Patient.birthDate
        * Patient.gender
        * Patient.identifier
        * Patient.identifier.value
        * Patient.link
        * Patient.name
      )

      id :ipa_v100_patient_must_support_test

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
