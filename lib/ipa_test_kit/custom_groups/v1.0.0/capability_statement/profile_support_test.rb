module IpaTestKit
  module IpaV100
    class ProfileSupportTest < Inferno::Test
      id :ipa_100_profile_support
      title 'Capability Statement lists support for required IPA Profiles'
      description %(
        The IPA Implementation Guide states:

        ```
        The IPA Server SHALL:
        1. Support the IPA Patient resource profile.
        2. Support at least one additional resource profile from the list of IPA
            Profiles.
        ```
      )
      uses_request :capability_statement

      PROFILES = {
        'AllergyIntolerance' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-allergyintolerance'].freeze,
        'Condition' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-condition'].freeze,
        'DocumentReference' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-documentreference'].freeze,
        'Immunization' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-immunization'].freeze,
        # 'Medication' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medication'].freeze,
        'MedicationRequest' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest'].freeze,
        'MedicationStatement' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationstatement'].freeze,
        'Observation' => [
          'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation'
        ].freeze,
        'Patient' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-patient'].freeze,
        'Practitioner' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner'].freeze,
        'PractitionerRole' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitionerrole'].freeze
      }.freeze

      run do
        assert_resource_type(:capability_statement)
        capability_statement = resource

        supported_resources =
          capability_statement.rest
            &.each_with_object([]) do |rest, resources|
              rest.resource.each { |resource| resources << resource.type }
            end.uniq
        supported_profiles =
          capability_statement.rest
            &.flat_map(&:resource)
            &.flat_map { |resource| resource.supportedProfile + [resource.profile] }
            &.compact || []
        supported_profiles.map! { |profile_url| profile_url.split('|').first }

        assert supported_resources.include?('Patient'), 'IPA Patient profile not supported'

        other_resources = PROFILES.keys.reject { |resource_type| resource_type == 'Patient' }
        other_resources_supported = other_resources.any? { |resource| supported_resources.include? resource }
        assert other_resources_supported, 'No IPA resources other than Patient are supported'

        required_profiles = PROFILES.slice(*supported_resources).values.flatten

        missing_profiles = required_profiles - supported_profiles

        assert missing_profiles.blank?,
               "CapabilityStatement does not claim support for the following IPA profiles: \n* #{missing_profiles.join("\n* ")}"
      end
    end
  end
end
