require_relative '../../reference_resolution_test'

module IpaTestKit
  class MedicationRequestReferenceResolutionTest < Inferno::Test
    include IpaTestKit::ReferenceResolutionTest

    title 'Every reference within MedicationRequest resources can be read'
    description %(
      This test will attempt to read the first 50 references found in the
      resources from the first search. The test will fail if Inferno fails to
      read any of those references.
    )

    id :ipa_010_medication_request_reference_resolution_test

    def resource_type
      'MedicationRequest'
    end

    def scratch_resources
      scratch[:medication_request_resources] ||= {}
    end

    run do
      perform_reference_resolution_test(scratch_resources[:all])
    end
  end
end
