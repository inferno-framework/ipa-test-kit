require_relative 'naming'
require_relative 'special_cases'

module IpaTestKit
  class Generator
    class MustSupportTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
            .reject { |group| SpecialCases.exclude_group? group }
            .each { |group| new(group, base_output_dir).generate }
        end
      end

      attr_accessor :group_metadata, :base_output_dir

      def initialize(group_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'must_support.rb.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, profile_identifier)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def read_interaction
        self.class.read_interaction(group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "ipa_#{group_metadata.reformatted_version}_#{profile_identifier}_must_support_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}MustSupportTest"
      end

      def module_name
        "Ipa#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def resource_collection_string
        'all_scratch_resources'
      end

      def must_support_list_string
        build_must_support_list_string
      end

      def build_must_support_list_string
        slice_names = group_metadata.must_supports[:slices]
          .map { |slice| slice[:slice_id] }

        element_names = group_metadata.must_supports[:elements]
          .map { |element| "#{resource_type}.#{element[:path]}" }

        extension_names = group_metadata.must_supports[:extensions]
          .map { |extension| extension[:id] }

        group_metadata.must_supports[:choices]&.each do |choice|
          choice[:paths].each { |path| element_names.delete("#{resource_type}.#{path}") }
          element_names << choice[:paths].map { |path| "#{resource_type}.#{path}" }.join(' or ')
        end

        (slice_names + element_names + extension_names)
          .uniq
          .sort
          .map { |name| "#{' ' * 8}* #{name}" }
          .join("\n")
      end

      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.open(output_file_name, 'w') { |f| f.write(output) }

        group_metadata.add_test(
          id: test_id,
          file_name: base_output_file_name
        )
      end
    end
  end
end
