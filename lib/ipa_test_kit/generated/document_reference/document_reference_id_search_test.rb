require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class DocumentReferenceIdSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for DocumentReference search by _id'
    description %(
A server SHALL support searching by
_id on the DocumentReference resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[IPA Server CapabilityStatement](https://build.fhir.org/ig/HL7/fhir-ipa/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_document_reference__id_search_test
    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'DocumentReference',
        search_param_names: ['_id'],
        possible_status_search: true
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:document_reference_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
