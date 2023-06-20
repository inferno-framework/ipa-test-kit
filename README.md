# Inferno International Patient Access (IPA) Test Kit

The Inferno International Patient Access Test Kit provides an
executable set of tests for the [International Patient Access (IPA)
Implementation Guide](https://build.fhir.org/ig/HL7/fhir-ipa/).  This test kit
is designed and maintained by the Inferno team to support the development of the
IPA IG and improve the core Inferno Framework.

This test kit includes a web interface to run a configured local [HL7® FHIR®
validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator)
service to validate instances of FHIR resources to the IPA profiles, as well as
a preliminary test suite based on the [Inferno US
Core](https://github.com/inferno-framework/us-core-test-kit) test suite.

The [Office of the National Coordinator for Health IT
(ONC)](https://healthit.gov) provides a running instance of these tests that can
be accessed at https://inferno.healthit.gov/suites/ipa_v100

## Local Installation Instructions (Docker required)

- Install [Docker](https://www.docker.com)
- Clone this repository
- Run `setup.sh` in this repo to pull the needed docker images and set up the
  database.
- Run `run.sh` to build and run the Inferno environment
- Navigate to `http://localhost` to access the Inferno IPA Test Suite
- Navigate to `http://localhost/validator` to access a FHIR resource validator,
  configured to validate against the IPA FHIR profiles


## Maintaining this Test Kit

The tests within this Test Kit are created using a generator that parses
the implementation guide provided in `./lib/ipa_test_kit/igs` and writes
Inferno DSL tests to `./lib/ipa_test_kit/generated`.  Resource instances
are validated using the HL7 FHIR Validator, and will use the tx.fhir.org
terminology service to validate terminology by default.

To update this test kit to a new version of the IG:

1. Add the .tgz file in `./lib/ipa_test_kit/igs` with the new version
of the IG package.  This will automatically be uploaded to the HL7
FHIR Validator to validate resource instance when the Inferno is started.
2. Run the generator to generate a new version-specific copy of the IPA suite.
   After installing Ruby, run the following:

```sh
bundle install
bundle exec rake ipa:generate
```

3. Tell Inferno to load the new version of the test suite by
adding a new line to `./lib/ipa_test_kit.rb`, similar to
the existing lines.  For example:

```ruby
require_relative 'ipa_test_kit/generated/v2.0.0/ipa_test_suite'
```

While the tests should be stable, the generator is still under development and
will likely need to be updated if there is any major structural changes to how
the implementation guide represents constraints.  For example, if the
implementation guide alters its strategy for conveying Must Support
requirements, the generator will need to be updated.

The generator is located in `./lib/ipa_test_kit/generator`, and is a fork of the
US Core generator after being altered based on differing requirements.  Updates include:

- Inclusion of a full set of search parameters from the FHIR specification, as
  IPA does not provide a copy of them like US Core does.
- Altered method for validating Provenance records, as there is no requirement
  for supporting Provenance READ interaction.
  
## TODOS

* Support `client-confidential-asymmetric`.
* Verify that the server supports all required SMART capabilities, rather than
  just verifying that the server advertises support for them.
* Test `$docref` operation.
* Test `Patient.link` requirements.
* Verify that the server requires both a code and system for Patient identifier
  search.

## License

Copyright 2023 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at

```md
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
