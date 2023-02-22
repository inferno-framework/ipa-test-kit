module IpaTestKit
  module IpaV100
    class InstantiatesIGTest < Inferno::Test
      id :ipa_100_instantiates_ig
      title 'FHIR server advertises support for the IPA IG'
      description %(
        The server declares that IPA is supported using
        `CapabilityStatement.instantiates`
      )
      uses_request :capability_statement

      run do
        assert_resource_type(:capability_statement)

        ig_url = 'http://hl7.org/fhir/uv/ipa/CapabilityStatement/ipa'

        assert resource.instantiates.include?(ig_url),
               "The server does not advertise support for the IPA IG by including `#{ig_url}` in the `instantiates` field"
      end
    end
  end
end
