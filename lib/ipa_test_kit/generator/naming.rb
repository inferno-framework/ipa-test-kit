module IpaTestKit
  class Generator
    module Naming
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-allergyintolerance'
      CONDITION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-condition'
      DOCUMENT_REFERENCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-documentreference'
      IMMUNIZATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-immunization'
      MEDICATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medication'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest'
      MEDICATION_STATEMENT = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationstatement'
      OBSERVATION = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation'
      BMI = 'http://hl7.org/fhir/StructureDefinition/bmi'
      OXYGEN_SAT = 'http://hl7.org/fhir/StructureDefinition/oxygensat'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/StructureDefinition/headcircum'
      PATIENT = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-patient'
      PRACTITIONER = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitionerrole'
      PROVENANCE = 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-provenance'

      class << self
        def resources_with_multiple_profiles
          ['Observation']
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
            .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end
      end
    end
  end
end
