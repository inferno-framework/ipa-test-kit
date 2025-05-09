require 'smart_app_launch_test_kit'

require_relative '../../custom_groups/v1.0.0/capability_statement_group'
require_relative '../../custom_groups/v1.0.0/ipa_smart_launch_group'
require_relative '../../provenance_validator'
require_relative 'patient_group'
require_relative 'allergy_intolerance_group'
require_relative 'condition_group'
require_relative 'problem_list_item_group'
require_relative 'document_reference_group'
require_relative 'immunization_group'
require_relative 'medication_request_group'
require_relative 'medication_statement_group'
require_relative 'observation_group'
require_relative 'vitalsigns_group'
require_relative 'medication_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'

module IpaTestKit
  module IpaV100
    class IpaTestSuite < Inferno::TestSuite
      title 'International Patient Access (v1.0.0)'
      short_title 'IPA v1.0.0'
      description %(
        This test suite evaluates the ability of a system to support applications
        acting on behalf of patients to access clinical records using an HL7® FHIR® R4 API
        in accordance to the [International Patient Access Implementation Guide (IPA IG)](https://www.hl7.org/fhir/uv/ipa/).
        
        It accomplishes this by simulating requests performed by a realistic IPA Requestor
        and validating responses based on requirements specified within the IPA IG and
        the base FHIR specification.

        Resources are validated with the FHIR Java validator using `tx.fhir.org`
        as the terminology server.

        The following are not yet implemented:
        * Test for `client-confidential-asymmetric`.
        * Verify that the server supports all required SMART capabilities, rather than
          just verifying that the server advertises support for them.
        * Test `$docref` operation.
        * Test `Patient.link` requirements.
        * Verify that the server requires both a code and system for Patient identifier
          search.
      )
      id :ipa_v100

      VALIDATION_MESSAGE_FILTERS = [
        %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /\A\S+: \S+: URL value '.*' does not resolve/,
      ].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      fhir_resource_validator do
        igs 'hl7.fhir.uv.ipa#1.0.0'

        exclude_message do |message|
          VALIDATION_MESSAGE_FILTERS.any? { |filter| filter.match? message.message }
        end

        perform_additional_validation do |resource, profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint'

      input :smart_auth_info,
        type: :auth_info,
        title: 'SMART Authorization Information',
        optional: true

      fhir_client do
        url :url
        auth_info :smart_auth_info
      end

      group from: :ipa_v100_smart_launch,
            config: {
              inputs: {
                smart_auth_info: { name: :smart_auth_info }
                # TODO asymmetric smart auth info
              },
              outputs: {
                smart_auth_info: { name: :smart_auth_info }
              }
            }

      group do
        title 'IPA Responder Tests'
        description %(
          The IPA Responder Tests evaluate the ability of an IPA Responder (IPA FHIR Server)
          to support required and optional FHIR operations and search parameters to return
          conformant IPA resources.
        )

        group from: :ipa_v100_capability_statement
    
        group from: :ipa_v100_patient
        group from: :ipa_v100_allergy_intolerance
        group from: :ipa_v100_condition
        group from: :ipa_v100_problem_list_item
        group from: :ipa_v100_document_reference
        group from: :ipa_v100_immunization
        group from: :ipa_v100_medication_request
        group from: :ipa_v100_medication_statement
        group from: :ipa_v100_observation
        group from: :ipa_v100_vitalsigns
        group from: :ipa_v100_medication
        group from: :ipa_v100_practitioner
        group from: :ipa_v100_practitioner_role
      end

      links [
        {
          type: 'report_issue',
          label: 'Report Issue',
          url: 'https://github.com/inferno-framework/ipa-test-kit/issues/'
        },
        {
          type: 'source_code',
          label: 'Open Source',
          url: 'https://github.com/inferno-framework/ipa-test-kit/'
        },
        {
          type: 'download',
          label: 'Download', 
          url: 'https://github.com/inferno-framework/ipa-test-kit/releases/'
        }
      ]

    end
  end
end
