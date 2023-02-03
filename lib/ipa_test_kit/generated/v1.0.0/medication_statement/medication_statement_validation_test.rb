require_relative '../../../validation_test'

module IpaTestKit
  module IpaV100PREVIEW
    class MedicationStatementValidationTest < Inferno::Test
      include IpaTestKit::ValidationTest

      id :ipa_v100preview_medication_statement_validation_test
      title 'MedicationStatement resources returned during previous tests conform to the IPA-MedicationStatement'
      description %(
This test verifies resources returned from the first search conform to
the [IPA-MedicationStatement](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationstatement).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'MedicationStatement'
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-medicationstatement',
                                '1.0.0-preview',
                                skip_if_empty: true)
      end
    end
  end
end
