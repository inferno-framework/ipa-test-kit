require_relative '../../read_test'

module IpaTestKit
  class MedicationStatementReadTest < Inferno::Test
    include IpaTestKit::ReadTest

    title 'Server returns correct MedicationStatement resource from MedicationStatement read interaction'
    description 'A server SHALL support the MedicationStatement read interaction.'

    id :ipa_010_medication_statement_read_test

    def resource_type
      'MedicationStatement'
    end

    def scratch_resources
      scratch[:medication_statement_resources] ||= {}
    end

    run do
      perform_read_test(all_scratch_resources)
    end
  end
end
