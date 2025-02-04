require_relative 'version'

module IpaTestKit
  class Metadata < Inferno::TestKit
    id :ipa_test_kit
    title 'International Patient Acess Test Kit'
    suite_ids [:ipa_v100]
    tags ['SMART App Launch']
    last_updated IpaTestKit::LAST_UPDATED
    version IpaTestKit::VERSION
    maturity 'Medium'
    authors ['Inferno Core Team']
    repo 'https://github.com/inferno-framework/ipa-test-kit'
    description <<~DESCRIPTION
      The International Patient Access Test Kit provides an executable set of tests for the [International Patient Access (IPA) Implementation Guide v1.0.0](https://hl7.org/fhir/uv/ipa/STU1/). This test kit evaluates the ability of a system to support applications acting on behalf of patients to access clinical records using an HL7® FHIR® R4 API in accordance to the IPA IG. It accomplishes this by simulating requests performed by a realistic IPA Requestor and validating responses based on requirements specified within the IPA IG and the base FHIR specification.
      <!-- break -->

      This test kit is [open source](https://github.com/inferno-framework/ipa-test-kit#license) and freely available for use or adoption by the health IT community including EHR vendors, health app developers, and testing labs. It is built using the [Inferno Framework](https://inferno-framework.github.io/inferno-core/). The Inferno Framework is designed for reuse and aims to make it easier to build test kits for any FHIR-based data exchange.

      ## Status

      These tests are intended to allow IPA server implementers to perform checks of their server against IPA requrirements. Future versions of these tests may validate other requirements and may change how these are tested.

      The test kit currently tests the following requirements:

       - SMART App Launch Protocol’s standalone launch sequence
       - Support for Capability Statement
       - Support for all IPA Profiles
       - Searches required for each resource
       - Support for Must Support Elements
       - Profile Validation
       - Reference Validation

      See the test descriptions within the test kit for detail on the specific validations performed as part of testing these requirements.

      The following are not yet implemented:

       - Test for client-confidential-asymmetric.
       - Verify that the server supports all required SMART capabilities, rather than just verifying that the server advertises support for them.
       - Test $docref operation.
       - Test Patient.link requirements.
       - Verify that the server requires both a code and system for Patient identifier search.

      ## Repository

      The IPA Test Kit GitHub repository can be [found here](https://github.com/inferno-framework/ipa-test-kit).

      ## Providing Feedback and Reporting Issues

      We welcome feedback on the tests, including but not limited to the following areas:

      - Validation logic, such as potential bugs, lax checks, and unexpected failures.
      - Requirements coverage, such as requirements that have been missed, tests that necessitate features that the IG does not require, or other issues with the interpretation of the IG’s requirements.
      - User experience, such as confusing or missing information in the test UI.

      Please report any issues with this set of tests in the [issues section](https://github.com/inferno-framework/ipa-test-kit/issues) of the repository.
    DESCRIPTION
  end
end
