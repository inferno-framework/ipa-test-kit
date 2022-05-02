require_relative '../../must_support_test'

module IpaTestKit
  class PractitionerRoleMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the PractitionerRole resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the PractitionerRole resources
      found previously for the following must support elements:

      * PractitionerRole.identifier
      * PractitionerRole.identifier.system
      * PractitionerRole.identifier.value
      * PractitionerRole.identifier:NPI
      * PractitionerRole.name
      * PractitionerRole.name.family
    )

    id :ipa_010_practitioner_role_must_support_test

    def resource_type
      'PractitionerRole'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:practitioner_role_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
