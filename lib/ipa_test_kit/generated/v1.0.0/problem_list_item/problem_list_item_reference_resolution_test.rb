require_relative '../../../reference_resolution_test'
require_relative '../resource_list'

module IpaTestKit
  module IpaV100
    class ProblemListItemReferenceResolutionTest < Inferno::Test
      include IpaTestKit::ReferenceResolutionTest
      include ResourceList

      title 'MustSupport references within Condition resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding IPA profile.

        Elements which may provide external references include:

        * Condition.subject
      )

      id :ipa_v100_problem_list_item_reference_resolution_test

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
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
