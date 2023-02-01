require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100PREVIEW
    class ObservationMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.code
        * Observation.dataAbsentReason
        * Observation.effective[x]
        * Observation.status
        * Observation.subject
        * Observation.value[x]
      )

      id :ipa_v100preview_observation_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
