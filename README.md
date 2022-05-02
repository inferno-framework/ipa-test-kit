# Inferno International Patient Access (IPA) Test Kit

The Inferno International Patient Access Test Kit provides an
executable set of tests for the [International Patient Access (IPA)
Implementation Guide](https://build.fhir.org/ig/HL7/fhir-ipa/).  This test kit
is designed and maintained by the Inferno team to support the development of the
IPA IG and improve the core Inferno Framework.

This test kit includes a web interface to run a configured local [HL7
validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator)
service to validate instances of FHIR resources to the IPA profiles, as well as
a preliminary test suite based on the [Inferno US
Core](https://github.com/inferno-framework/us-core-test-kit) test suite.

The [Office of the National Coordinator for Health IT (ONC)](https://healthit.gov) provides a running instance of these tests that can be accessed
at https://inferno.healthit.gov/suites/

## Local Installation Instructions (Docker required)

- Install [Docker](https://www.docker.com)
- Clone this repository
- Run `setup.sh` in this repo to pull the needed docker images and set up the
  database.
- Run `run.sh` to build and run the Inferno environment
- Navigate to `http://localhost` to access the Inferno IPA Test Suite
- Navigate to `http://localhost/validator` to access a FHIR resource validator,
  configured to validate against the IPA FHIR profiles

## License
Copyright 2022 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at
```
http://www.apache.org/licenses/LICENSE-2.0
```
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
