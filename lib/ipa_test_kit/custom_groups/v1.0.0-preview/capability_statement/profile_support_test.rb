module IpaTestKit
  module IpaV100PREVIEW
    class ProfileSupportTest < Inferno::Test
      id :ipa_010_profile_support
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
        'Medication' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medication'].freeze,
        'MedicationRequest' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest'].freeze,
        'MedicationStatement' => ['http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationstatement'].freeze,
        'Observation' => [
          'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation',
          'http://hl7.org/fhir/StructureDefinition/bp/bmi',
          'http://hl7.org/fhir/StructureDefinition/bp/oxygensat',
          'http://hl7.org/fhir/StructureDefinition/bp',
          'http://hl7.org/fhir/StructureDefinition/bodyheight',
          'http://hl7.org/fhir/StructureDefinition/bodyweight',
          'http://hl7.org/fhir/StructureDefinition/heartrate',
          'http://hl7.org/fhir/StructureDefinition/resprate',
          'http://hl7.org/fhir/StructureDefinition/bodytemp',
          'http://hl7.org/fhir/StructureDefinition/headcircum'
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

        PROFILES.each do |resource_type, profiles|
          next unless supported_resources.include? resource_type

          profiles.each do |profile|
            warning do
              assert supported_profiles&.include?(profile),
                      "CapabilityStatement does not claim support for IPA #{resource_type} profile: #{profile}"
            end
          end
        end
      end
    end
  end
end
