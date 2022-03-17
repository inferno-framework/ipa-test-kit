module IpaTestKit
  class Generator
    module Naming
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-allergyintolerance'
      CARE_PLAN = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-careplan'
      CARE_TEAM = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-careteam'
      CONDITION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-condition'
      IMPLANTABLE_DEVICE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-implantable-device'
      DIAGNOSTIC_REPORT_NOTE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-diagnosticreport-note'
      DIAGNOSTIC_REPORT_LAB = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-diagnosticreport-lab'
      DOCUMENT_REFERENCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-documentreference'
      ENCOUNTER = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-encounter'
      GOAL = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-goal'
      IMMUNIZATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-immunization'
      LOCATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-location'
      MEDICATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medication'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest'
      SMOKING_STATUS = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-smokingstatus'
      PEDIATRIC_WEIGHT_FOR_HEIGHT = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/pediatric-weight-for-height'
      OBSERVATION_LAB = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation-lab'
      PEDIATRIC_BMI_FOR_AGE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/pediatric-bmi-for-age'
      PULSE_OXIMETRY = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-pulse-oximetry'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/head-occipital-frontal-circumference-percentile'
      ORGANIZATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-organization'
      PATIENT = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-patient'
      PRACTITIONER = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitionerrole'
      PROCEDURE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-procedure'
      PROVENANCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-provenance'

      class << self
        def resources_with_multiple_profiles
          ['Observation', 'DiagnosticReport']
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          return 'head_circumference' if group_metadata.profile_url == HEAD_CIRCUMFERENCE

          group_metadata.name
            .delete_prefix('ipa_')
            .gsub('diagnosticreport', 'diagnostic_report')
            .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end
      end
    end
  end
end
