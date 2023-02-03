require_relative 'practitioner/practitioner_read_test'
require_relative 'practitioner/practitioner_validation_test'
require_relative 'practitioner/practitioner_must_support_test'

module IpaTestKit
  module IpaV100PREVIEW
    class PractitionerGroup < Inferno::TestGroup
      title 'IPA-Practitioner Tests'
      short_description 'Verify support for the server capabilities required by the IPA-Practitioner.'
      description %(
  # Background

The IPA IPA-Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the IPA-Practitioner as
specified in the IPA v1.0.0-preview Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Practitioner resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [IPA-Practitioner](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner). Each element is checked against
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

      id :ipa_v100preview_practitioner
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'practitioner', 'metadata.yml'), aliases: true))
      end
  
      test from: :ipa_v100preview_practitioner_read_test
      test from: :ipa_v100preview_practitioner_validation_test
      test from: :ipa_v100preview_practitioner_must_support_test
    end
  end
end
