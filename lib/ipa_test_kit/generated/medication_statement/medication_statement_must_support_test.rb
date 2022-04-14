require_relative '../../must_support_test'

module IpaTestKit
  class MedicationStatementMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the MedicationStatement resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the MedicationStatement resources
      found previously for the following must support elements:

      * MedicationStatement.authoredOn
      * MedicationStatement.dosageInstruction
      * MedicationStatement.dosageInstruction.text
      * MedicationStatement.encounter
      * MedicationStatement.intent
      * MedicationStatement.medication[x]
      * MedicationStatement.reported[x]
      * MedicationStatement.requester
      * MedicationStatement.status
      * MedicationStatement.subject
    )

    id :ipa_010_medication_statement_must_support_test

    def resource_type
      'MedicationStatement'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:medication_statement_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
