require_relative 'naming'
require_relative 'special_cases'

module IpaTestKit
  class Generator
    class SuiteGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          new(ig_metadata, base_output_dir).generate
        end
      end

      attr_accessor :ig_metadata, :base_output_dir

      def initialize(ig_metadata, base_output_dir)
        self.ig_metadata = ig_metadata
        self.base_output_dir = base_output_dir
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

      def module_name
        "Ipa#{ig_metadata.reformatted_version.upcase}"
      end

      def output_file_name
        File.join(base_output_dir, base_output_file_name)
      end

      def suite_id
        "ipa_#{ig_metadata.reformatted_version}"
      end

      def title
        "International Patient Access (#{ig_metadata.ig_version})"
      end

      def short_title
        "IPA #{ig_metadata.ig_version}"
      end

      def validator_env_name
        "IPA_#{ig_metadata.reformatted_version.upcase}_FHIR_RESOURCE_VALIDATOR_URL"
      end

      def ig_identifier
        version = ig_metadata.ig_version[1..] # Remove leading 'v'
        "hl7.fhir.uv.ipa##{version}"
      end

      def ig_link
        'http://build.fhir.org/ig/HL7/fhir-ipa/'
      end

      def generate
        File.open(output_file_name, 'w') { |f| f.write(output) }
      end

      def groups
        ig_metadata.ordered_groups
          .reject { |group| SpecialCases.exclude_group? group }
      end

      def group_id_list
        @group_id_list ||=
          groups.map(&:id)
      end

      def group_file_list
        @group_file_list ||=
          groups.map { |group| group.file_name.delete_suffix('.rb') }
      end

      def capability_statement_file_name
        "../../custom_groups/#{ig_metadata.ig_version}/capability_statement_group"
      end

      def capability_statement_group_id
        "ipa_#{ig_metadata.reformatted_version}_capability_statement"
      end

      def smart_launch_file_name
        "../../custom_groups/#{ig_metadata.ig_version}/ipa_smart_launch_group"
      end

      def smart_launch_group_id
        "ipa_#{ig_metadata.reformatted_version}_smart_launch"
      end
    end
  end
end
