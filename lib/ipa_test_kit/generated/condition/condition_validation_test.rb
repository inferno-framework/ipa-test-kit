require_relative '../../validation_test'

module IpaTestKit
  class ConditionValidationTest < Inferno::Test
    include IpaTestKit::ValidationTest

    id :ipa_010_condition_validation_test
    title 'Condition resources returned during previous tests conform to the IPA Condition Profile'
    description %(
This test verifies resources returned from the first search conform to
the [IPA Condition Profile](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-condition).

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

    )
    output :dar_code_found, :dar_extension_found

    def resource_type
      'Condition'
    end

    def scratch_resources
      scratch[:condition_resources] ||= {}
    end

    run do
      perform_validation_test(scratch_resources[:all] || [], 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-condition')
    end
  end
end
