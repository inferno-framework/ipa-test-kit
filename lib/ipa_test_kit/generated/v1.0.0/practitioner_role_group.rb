require_relative 'practitioner_role/practitioner_role_read_test'
require_relative 'practitioner_role/practitioner_role_validation_test'
require_relative 'practitioner_role/practitioner_role_must_support_test'
require_relative 'practitioner_role/practitioner_role_reference_resolution_test'

module IpaTestKit
  module IpaV100
    class PractitionerRoleGroup < Inferno::TestGroup
      title 'PractitionerRole Tests'
      short_description 'Verify support for the server capabilities required by the IPA-PractitionerRole.'
      description %(
  # Background

The IPA PractitionerRole sequence verifies that the system under test is
able to provide correct responses for PractitionerRole queries. These queries
must contain resources conforming to the IPA-PractitionerRole as
specified in the IPA v1.0.0 Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the PractitionerRole resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [IPA-PractitionerRole](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitionerrole). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :ipa_v100_practitioner_role
      run_as_group
      input :smart_auth_info,
            title: 'SMART Authorization Information',
            type: 'auth_info',
            optional: true

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'practitioner_role', 'metadata.yml'), aliases: true))
      end
  
      test from: :ipa_v100_practitioner_role_read_test, config: { options: { read_all_resources: true } }
      test from: :ipa_v100_practitioner_role_validation_test
      test from: :ipa_v100_practitioner_role_must_support_test
      test from: :ipa_v100_practitioner_role_reference_resolution_test
    end
  end
end
