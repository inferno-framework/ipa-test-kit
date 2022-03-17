require_relative '../../must_support_test'

module IpaTestKit
  class CareTeamMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the CareTeam resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the CareTeam resources
      found previously for the following must support elements:

      * CareTeam.participant
      * CareTeam.participant.member
      * CareTeam.participant.role
      * CareTeam.status
      * CareTeam.subject
    )

    id :ipa_010_care_team_must_support_test

    def resource_type
      'CareTeam'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:care_team_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
