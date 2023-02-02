require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100PREVIEW
    class ProblemListItemMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'
      description %(
        IPA Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the IPA Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.category
        * Condition.category:problem-list-item
        * Condition.clinicalStatus
        * Condition.code
        * Condition.subject
        * Condition.verificationStatus
      )

      id :ipa_v100preview_problem_list_item_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:problem_list_item_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
