require_relative '../../../validation_test'

module IpaTestKit
  module IpaV100
    class AllergyIntoleranceValidationTest < Inferno::Test
      include IpaTestKit::ValidationTest

      id :ipa_v100_allergy_intolerance_validation_test
      title 'AllergyIntolerance resources returned during previous tests conform to the IPA-AllergyIntolerance'
      description %(
This test verifies resources returned from the first search conform to
the [IPA-AllergyIntolerance](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-allergyintolerance).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'AllergyIntolerance'
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-allergyintolerance',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
