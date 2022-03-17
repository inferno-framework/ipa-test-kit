require_relative '../../must_support_test'

module IpaTestKit
  class DocumentReferenceMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the DocumentReference resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the DocumentReference resources
      found previously for the following must support elements:

      * DocumentReference.author
      * DocumentReference.category
      * DocumentReference.content
      * DocumentReference.content.attachment
      * DocumentReference.content.attachment.contentType
      * DocumentReference.content.format
      * DocumentReference.context
      * DocumentReference.context.encounter
      * DocumentReference.context.period
      * DocumentReference.custodian
      * DocumentReference.date
      * DocumentReference.identifier
      * DocumentReference.status
      * DocumentReference.subject
      * DocumentReference.type
    )

    id :ipa_010_document_reference_must_support_test

    def resource_type
      'DocumentReference'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:document_reference_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
