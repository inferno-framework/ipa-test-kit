require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class MedicationStatementMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationStatement resources returned'
      description %(
        Responders conforming to a profile in IPA SHALL return a Must Support
        element if that element is available. This test will look through the
        MedicationStatement resources found previously for the following must
        support elements:

        * MedicationStatement.context
        * MedicationStatement.dosage
        * MedicationStatement.dosage.text
        * MedicationStatement.effective[x]
        * MedicationStatement.informationSource
        * MedicationStatement.medication[x]
        * MedicationStatement.status
        * MedicationStatement.statusReason
        * MedicationStatement.subject

        Note: Responders who cannot store or return a data element tagged as
        Supported in IPA profiles can still claim conformance to the IPA
        profiles per the IPA conformance resources.
      )

      id :ipa_v100_medication_statement_must_support_test

      optional

      def resource_type
        'MedicationStatement'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
