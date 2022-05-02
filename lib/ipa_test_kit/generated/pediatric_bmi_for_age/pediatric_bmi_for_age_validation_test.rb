require_relative '../../validation_test'

module IpaTestKit
  class PediatricBmiForAgeValidationTest < Inferno::Test
    include IpaTestKit::ValidationTest

    id :ipa_010_pediatric_bmi_for_age_validation_test
    title 'Observation resources returned during previous tests conform to the IPA Pediatric BMI for Age Observation Profile'
    description %(
This test verifies resources returned from the first search conform to
the [IPA Pediatric BMI for Age Observation Profile](http://hl7.org/fhir/uv/ipa/StructureDefinition/pediatric-bmi-for-age).

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
      scratch[:pediatric_bmi_for_age_resources] ||= {}
    end

    run do
      perform_validation_test(scratch_resources[:all] || [], 'http://hl7.org/fhir/uv/ipa/StructureDefinition/pediatric-bmi-for-age')
    end
  end
end
