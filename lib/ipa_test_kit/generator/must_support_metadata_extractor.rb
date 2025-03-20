require_relative 'value_extractor'

require 'inferno'

module IpaTestKit
  class Generator
    class MustSupportMetadataExtractor < Inferno::DSL::MustSupportMetadataExtractor
      def must_supports
        @must_supports = super

        handle_special_cases

        @must_supports
      end

      #### SPECIAL CASE ####

      def handle_special_cases
        remove_vital_sign_component
        remove_blood_pressure_value
        add_must_support_choices

        case profile.version
        when '3.1.1'
          remove_document_reference_custodian
        when '4.0.0'
          add_device_distinct_identifier
        when '5.0.1'
          add_document_reference_category_values
          remove_survey_questionnaire_response
        end
      end

      def is_vital_sign?
        [
          'http://hl7.org/fhir/StructureDefinition/vitalsigns',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-vital-signs'
        ].include?(profile.baseDefinition)
      end

      def is_blood_pressure?
        ['observation-bp', 'IpaBloodPressureProfile'].include?(profile.name)
      end

      # Exclude Observation.component from vital sign profiles except observation-bp and observation-pulse-ox
      def remove_vital_sign_component
        if is_vital_sign? && !is_blood_pressure? && profile.name != 'IpaPulseOximetryProfile'
          @must_supports[:elements].delete_if do |element|
            element[:path].start_with?('component')
          end
        end
      end

      # Exclude Observation.value[x] from observation-bp
      def remove_blood_pressure_value
        if is_blood_pressure?
          @must_supports[:elements].delete_if do |element|
            element[:path].start_with?('value[x]') || element[:original_path]&.start_with?('value[x]')
          end
          @must_supports[:slices].delete_if do |slice|
            slice[:path].start_with?('value[x]')
          end
        end
      end

      def remove_device_carrier
        if profile.type == 'Device'
          @must_supports[:elements].delete_if do |element|
            ['udiCarrier.carrierAIDC', 'udiCarrier.carrierHRF'].include?(element[:path])
          end
        end
      end

      # US Core clarified that server implmentation is not required to support DocumentReference.custodian (FHIR-28393)
      def remove_document_reference_custodian
        if profile.type == 'DocumentReference'
          @must_supports[:elements].delete_if do |element|
            element[:path] == 'custodian'
          end
        end
      end

      def remove_document_reference_attachment_data_url
        if profile.type == 'DocumentReference'
          @must_supports[:elements].delete_if do |element|
            ['content.attachment.data', 'content.attachment.url'].include?(element[:path])
          end
        end
      end

      def add_must_support_choices
        choices = []

        choices << { paths: ['content.attachment.data', 'content.attachment.url'] } if profile.type == 'DocumentReference'

        case profile.version
        when '3.1.1'
          choices << { paths: ['udiCarrier.carrierAIDC', 'udiCarrier.carrierHRF'] } if profile.type == 'Device'
        when '4.0.0'
          case profile.type
          when 'Encounter'
            choices << { paths: ['reasonCode', 'reasonReference'] }
            choices << { paths: ['location.location', 'serviceProvider'] }
          when 'MedicationRequest'
            choices << { paths: ['reportedBoolean', 'reportedReference'] }
          end
        when '5.0.1'
          case profile.type
          when 'CareTeam'
            choices << {
              target_profiles: [
                'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner',
                'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'
              ]
            }
          when 'Condition'
            choices << {
              paths: ['onsetDateTime'],
              extension_ids: ['Condition.extension:assertedDate']
            }
          when 'Encounter'
            choices << { paths: ['reasonCode', 'reasonReference'] }
            choices << { paths: ['location.location', 'serviceProvider'] }
          when 'MedicationRequest'
            choices << { paths: ['reportedBoolean', 'reportedReference'] }
          end
        end

        @must_supports[:choices] = choices if choices.present?
      end

      def add_device_distinct_identifier
        if profile.type == 'Device'
          # FHIR-36303 US Core 4.0.0 mistakenly removed MS from Device.distinctIdentifier
          # This will be fixed in US Core 5.0.0
          @must_supports[:elements] << {
            path: 'distinctIdentifier'
          }
        end
      end

      def add_document_reference_category_values
        return unless profile.type == 'DocumentReference'

        slice = @must_supports[:slices].find{|slice| slice[:path] == 'category'}

        slice[:discriminator][:values] = ['clinical-note'] if slice.present?
      end

      # FHIR-37794 Server systems are not required to support US Core QuestionnaireResponse
      def remove_survey_questionnaire_response
        return unless profile.type == 'Observation' &&
          ['us-core-observation-survey', 'us-core-observation-sdoh-assessment'].include?(profile.id)

        element = @must_supports[:elements].find { |element| element[:path] == 'derivedFrom' }
        element[:target_profiles].delete_if do |url|
          url == 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-questionnaireresponse'
        end
      end
    end
  end
end
