module IpaTestKit
    class MedicationStatementTests < Inferno::Test
    title 'Medication Statement (IPA) Tests'
    description 'Verify support for the server capabilities required by the Medication Statement (IPA) profile.'
    id :ipa_medication_statement_tests

    input :medication_statement_id

    test do
      title 'Server returns correct MedicationStatement resource from the MedicationStatement read interaction'
      description %(
        This test will verify that MedicationStatement resources can be read from the server.
      )
      # link 'http://hl7.org/fhir/uv/ipa/StructureDefinition/MedicationStatement-uv-ipa'
      makes_request :medication_statement

      run do
        fhir_read(:medication_statement, medication_statement_id, name: :medication_statement)

        assert_response_status(200)
        assert_resource_type(:medication_statement)
        assert resource.id == medication_statement_id,
               "Requested resource with id #{medication_statement_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns MedicationStatement resource that matches the Medication Statement (IPA) profile'
      description %(
        This test will validate that the MedicationStatement resource returned from the server matches the Medication Statement (IPA) profile.
      )
      # link 'http://hl7.org/fhir/uv/ipa/StructureDefinition/MedicationStatement-ipa'
      uses_request :medication_statement

      run do
        assert_valid_resource(profile_url: 'http://hl7.org/fhir/uv/ipa/StructureDefinition/MedicationStatement-ipa')
      end
    end
  end
end
