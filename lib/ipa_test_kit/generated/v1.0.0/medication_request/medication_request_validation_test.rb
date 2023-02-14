require_relative '../../../validation_test'

module IpaTestKit
  module IpaV100
    class MedicationRequestValidationTest < Inferno::Test
      include IpaTestKit::ValidationTest

      id :ipa_v100_medication_request_validation_test
      title 'MedicationRequest resources returned during previous tests conform to the IPA-MedicationRequest'
      description %(
This test verifies resources returned from the first search conform to
the [IPA-MedicationRequest](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'MedicationRequest'
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationrequest',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
