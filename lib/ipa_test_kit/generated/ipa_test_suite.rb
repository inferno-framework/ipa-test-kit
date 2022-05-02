require 'inferno/dsl/oauth_credentials'
require_relative '../version'
require_relative '../custom_groups/capability_statement_group'
#require_relative '../custom_groups/clinical_notes_guidance_group'
#require_relative '../custom_groups/data_absent_reason_group'
require_relative 'patient_group'
require_relative 'allergy_intolerance_group'
#require_relative 'care_plan_group'
#require_relative 'care_team_group'
require_relative 'condition_group'
#require_relative 'device_group'
#require_relative 'diagnostic_report_note_group'
#require_relative 'diagnostic_report_lab_group'
require_relative 'document_reference_group'
#require_relative 'goal_group'
require_relative 'immunization_group'
require_relative 'medication_request_group'
require_relative 'medication_statement_group'
#require_relative 'smokingstatus_group'
#require_relative 'pediatric_weight_for_height_group'
require_relative 'observation_group'
#require_relative 'pediatric_bmi_for_age_group'
require_relative 'pulse_oximetry_group'
require_relative 'head_circumference_group'
require_relative 'bodyheight_group'
require_relative 'bodytemp_group'
require_relative 'bp_group'
require_relative 'bodyweight_group'
require_relative 'heartrate_group'
require_relative 'resprate_group'
#require_relative 'procedure_group'
#require_relative 'encounter_group'
#require_relative 'organization_group'
require_relative 'practitioner_group'
#require_relative 'provenance_group'

module IpaTestKit
  class IpaTestSuite < Inferno::TestSuite
    title 'International Patient Access (IPA)'
    version VERSION

    VALIDATION_MESSAGE_FILTERS = [
      %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris$},
      %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris$},
      /^Observation\.effective\.ofType\(Period\): vs-1:/, # Invalid invariant in FHIR v4.0.1
    ].freeze

    def self.metadata
      @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'))[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
    end

    validator do
      url ENV.fetch('VALIDATOR_URL', 'http://validator_service:4567')
      exclude_message do |message|
        VALIDATION_MESSAGE_FILTERS.any? { |filter| filter.match? message.message }
      end
    end

    id :ipa_010

    input :url,
      title: 'FHIR Endpoint',
      description: 'URL of the FHIR endpoint'
    input :smart_credentials,
      title: 'OAuth Credentials',
      type: :oauth_credentials,
      optional: true

    fhir_client do
      url :url
      oauth_credentials :smart_credentials
    end

    group from: :ipa_010_capability_statement

    group from: :ipa_010_patient
    group from: :ipa_010_allergy_intolerance
    #group from: :ipa_010_care_plan
    #group from: :ipa_010_care_team
    group from: :ipa_010_condition
    #group from: :ipa_010_device
    #group from: :ipa_010_diagnostic_report_note
    #group from: :ipa_010_diagnostic_report_lab
    group from: :ipa_010_document_reference
    #group from: :ipa_010_goal
    group from: :ipa_010_immunization
    group from: :ipa_010_medication_request
    group from: :ipa_010_medication_statement
    #group from: :ipa_010_smokingstatus
    #group from: :ipa_010_pediatric_weight_for_height
    group from: :ipa_010_observation
    #group from: :ipa_010_pediatric_bmi_for_age
    group from: :ipa_010_pulse_oximetry
    group from: :ipa_010_head_circumference
    group from: :ipa_010_bodyheight
    group from: :ipa_010_bodytemp
    group from: :ipa_010_bp
    group from: :ipa_010_bodyweight
    group from: :ipa_010_heartrate
    group from: :ipa_010_resprate
    #group from: :ipa_010_procedure
    #group from: :ipa_010_encounter
    #group from: :ipa_010_organization
    group from: :ipa_010_practitioner
    #group from: :ipa_010_provenance
    #group from: :ipa_010_clinical_notes_guidance
    #group from: :ipa_010_data_absent_reason
  end
end
