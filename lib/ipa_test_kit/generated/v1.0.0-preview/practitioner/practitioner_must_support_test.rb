require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100PREVIEW
    class PractitionerMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the Practitioner resources returned'
      description %(
        IPA Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the IPA Core Server Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

        * Practitioner.name
      )

      id :ipa_v100preview_practitioner_must_support_test

      def resource_type
        'Practitioner'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
