require_relative '../../validation_test'

module IpaTestKit
  class PractitionerValidationTest < Inferno::Test
    include IpaTestKit::ValidationTest

    id :ipa_010_practitioner_validation_test
    title 'Practitioner resources returned during previous tests conform to the IPA Practitioner Profile'
    description %(
This test verifies resources returned from the first search conform to
the [IPA Practitioner Profile](http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner).

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

    )
    output :dar_code_found, :dar_extension_found

    def resource_type
      'Practitioner'
    end

    def scratch_resources
      scratch[:practitioner_resources] ||= {}
    end

    run do
      perform_validation_test(scratch_resources[:all] || [], 'http://hl7.org/fhir/uv/ipa/StructureDefinition/ipa-practitioner')
    end
  end
end
