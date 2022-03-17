require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module IpaTestKit
  class OrganizationAddressSearchTest < Inferno::Test
    include IpaTestKit::SearchTest

    title 'Server returns valid results for Organization search by address'
    description %(
A server SHALL support searching by
address on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[IPA Server CapabilityStatement](http://hl7.org/fhir/uv/ipa/STU3.1.1/CapabilityStatement-ipa-server.html)

    )

    id :ipa_010_organization_address_search_test
    def self.properties
      @properties ||= SearchTestProperties.new(
        resource_type: 'Organization',
        search_param_names: ['address']
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:organization_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
