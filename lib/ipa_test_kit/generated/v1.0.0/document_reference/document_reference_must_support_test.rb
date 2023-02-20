require_relative '../../../must_support_test'

module IpaTestKit
  module IpaV100
    class DocumentReferenceMustSupportTest < Inferno::Test
      include IpaTestKit::MustSupportTest

      title 'All must support elements are provided in the DocumentReference resources returned'
      description %(
        Responders conforming to a profile in IPA SHALL return a Must Support
        element if that element is available. This test will look through the
        DocumentReference resources found previously for the following must
        support elements:

        * DocumentReference.author
        * DocumentReference.category
        * DocumentReference.content
        * DocumentReference.content.attachment
        * DocumentReference.content.attachment.contentType
        * DocumentReference.content.attachment.data or DocumentReference.content.attachment.url
        * DocumentReference.content.format
        * DocumentReference.context
        * DocumentReference.context.encounter
        * DocumentReference.context.period
        * DocumentReference.date
        * DocumentReference.status
        * DocumentReference.subject
        * DocumentReference.type

        Note: Responders who cannot store or return a data element tagged as
        Supported in IPA profiles can still claim conformance to the IPA
        profiles per the IPA conformance resources.
      )

      id :ipa_v100_document_reference_must_support_test

      optional

      def resource_type
        'DocumentReference'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:document_reference_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
