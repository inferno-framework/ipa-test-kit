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
