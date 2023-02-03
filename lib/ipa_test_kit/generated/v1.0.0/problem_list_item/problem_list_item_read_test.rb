require_relative '../../../read_test'

module IpaTestKit
  module IpaV100PREVIEW
    class ProblemListItemReadTest < Inferno::Test
      include IpaTestKit::ReadTest

      title 'Server returns correct Condition resource from Condition read interaction'
      description 'A server SHALL support the Condition read interaction.'

      id :ipa_v100preview_problem_list_item_read_test

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:problem_list_item_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
