require 'inferno/dsl/oauth_credentials'

require_relative '../../version'
require_relative '../../custom_groups/v1.0.0-preview/capability_statement_group'
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
require_relative 'practitioner_group'

module IpaTestKit
  module IpaV100PREVIEW
    class IpaTestSuite < Inferno::TestSuite
      title 'International Patient Access (v1.0.0-preview)'
      description %(
        The IPA Test Kit tests systems for their conformance to the [US Core
        Implementation Guide](http://build.fhir.org/ig/HL7/fhir-ipa/).

        Resources are validated with the FHIR Java validator using `tx.fhir.org`
        as the terminology server.
      )
      version VERSION

      VALIDATION_MESSAGE_FILTERS = [
      ].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      validator do
        url ENV.fetch('V100PREVIEW_VALIDATOR_URL', 'http://validator_service:4567')
        exclude_message do |message|
          VALIDATION_MESSAGE_FILTERS.any? { |filter| filter.match? message.message }
        end

        perform_additional_validation do |resource, profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      id :ipa_v100preview


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

      group from: :ipa_v100preview_capability_statement
  
      group from: :ipa_v100preview_patient
      group from: :ipa_v100preview_allergy_intolerance
      group from: :ipa_v100preview_condition
      group from: :ipa_v100preview_problem_list_item
      group from: :ipa_v100preview_document_reference
      group from: :ipa_v100preview_immunization
      group from: :ipa_v100preview_medication_request
      group from: :ipa_v100preview_medication_statement
      group from: :ipa_v100preview_observation
      group from: :ipa_v100preview_practitioner

    end
  end
end
