require_relative '../../../validation_test'

module IpaTestKit
  module IpaV100PREVIEW
    class ObservationValidationTest < Inferno::Test
      include IpaTestKit::ValidationTest

      id :ipa_v100preview_observation_validation_test
      title 'Observation resources returned during previous tests conform to the IPA-Observation'
      description %(
This test verifies resources returned from the first search conform to
the [IPA-Observation](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:observation_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-observation',
                                '1.0.0-preview',
                                skip_if_empty: true)
      end
    end
  end
end
