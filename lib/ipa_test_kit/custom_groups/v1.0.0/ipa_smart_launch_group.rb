require 'smart_app_launch_test_kit'

module IpaTestKit
  module IpaV100
    class IPASMARTLaunchGroup < Inferno::TestGroup
      id :ipa_v100_smart_launch
      title 'SMART App Launch'
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

        This group does not yet test launching with asymmetric client
        credentials, which is also required.
      )

      group from: :smart_discovery_stu2 do
        run_as_group

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
            run_as_group: true,
            title: 'SMART Public Standalone Launch',
            config: {
              inputs: {
                smart_auth_info: {
                  options: {
                    components: [
                      { name: :auth_type, default: 'public', locked: true },
                      { name: :pkce_support, default: 'enabled', locked: true },
                      { name: :pkce_code_challenge_method, default: 'S256', locked: true },
                      { name: :requested_scopes, default: 'launch/patient openid fhirUser offline_access patient/*.rs' }
                    ]
                  }
                }
              }
            }

      group do
        title 'SMART Asymmetric Standalone Launch'
        description %(
          Not yet implemented
        )
        run_as_group

        test do
          title 'Not yet implemented'
          run do
            omit 'Not yet implemented'
          end
        end
      end
    end
  end
end
