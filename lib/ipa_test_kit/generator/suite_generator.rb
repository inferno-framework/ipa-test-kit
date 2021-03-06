require_relative 'naming'
require_relative 'special_cases'

module IpaTestKit
  class Generator
    class SuiteGenerator
      class << self
        def generate(ig_metadata)
          new(ig_metadata).generate
        end
      end

      attr_accessor :ig_metadata

      def initialize(ig_metadata)
        self.ig_metadata = ig_metadata
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'suite.rb.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        "ipa_test_suite.rb"
      end

      def class_name
        "IpaTestSuite"
      end

      def output_file_name
        File.join(__dir__, '..', 'generated', base_output_file_name)
      end

      def suite_id
        'ipa_010'
      end

      def title
        'IPA 3.1.1'
      end

      def generate
        File.open(output_file_name, 'w') { |f| f.write(output) }
      end

      def groups
        ig_metadata.ordered_groups
          .reject { |group| SpecialCases.exclude_resource? group.resource }
      end

      def group_id_list
        @group_id_list ||=
          groups.map(&:id)
      end

      def group_file_list
        @group_file_list ||=
          groups.map { |group| group.file_name.delete_suffix('.rb') }
      end
    end
  end
end
