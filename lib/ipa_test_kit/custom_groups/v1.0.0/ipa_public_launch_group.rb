module IpaTestKit
  module IpaV100
    class IPAPublicLaunchGroup < Inferno::TestGroup
      id :ipa_v100_public_launch
      title 'Public SMART App Launch'
      description %(
        # Background
        Applications authorize to gain access to a patient record using the
        [SMART App Launch
        Protocol](http://hl7.org/fhir/smart-app-launch/STU2/)'s standalone
        launch sequence.

        # Testing Methodology
        These tests first access the server's SMART discovery endpoints and
        verify that they are available and that the server advertises support
        for the required SMART capabilities. They then perform a public
        standalone launch to obtain an access token which can be used by the
        remaining tests to access patient data.
      )
      run_as_group

      group from: :smart_discovery_stu2 do
        test do
          id :ipa_smart_capabilities
          title 'Server supports required SMART capabilities'
          description %(
            Servers SHALL support the following [SMART on FHIR
            capabilities](http://hl7.org/fhir/smart-app-launch/STU2/conformance.html#capabilities):

            * `launch-standalone`
            * `context-standalone-patient`
            * `permission-patient`
            * `permission-offline`
            * `sso-openid-connect`
            * `client-public`
            * `client-confidential-asymmetric`
          )

          input :well_known_configuration

          run do
            skip_if well_known_configuration.blank?, "No SMART well-known configuration received"

            assert_valid_json(well_known_configuration)

            config = JSON.parse(well_known_configuration)
            advertised_capabilities = config['capabilities'] || []

            assert advertised_capabilities.is_a?(Array),
                   "Expected `capabilities` field to be an Array, but found #{advertised_capabilities.class.name}"

            required_capabilities = [
              'launch-standalone',
              'context-standalone-patient',
              'permission-patient',
              'permission-offline',
              'sso-openid-connect',
              'client-public',
              'client-confidential-asymmetric'
            ]

            missing_capabilities = required_capabilities - advertised_capabilities

            missing_capabilities_string =
              missing_capabilities
                .map { |capability| "\n* `#{capability}`" }
                .join

            assert missing_capabilities.empty?,
                   "Server did not advertise support for the following required capabilities: #{missing_capabilities_string}"
          end
        end
      end

      group from: :smart_standalone_launch_stu2,
            config: {
              inputs: {
                client_secret: {
                  default: nil,
                  locked: true,
                  optional: true
                }
              }
            }
    end
  end
end
