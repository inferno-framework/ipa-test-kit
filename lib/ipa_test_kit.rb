require_relative 'ipa_test_kit/generated/v1.0.0/ipa_test_suite'

Inferno::Repositories::TestSuites.all.reject! { |suite| suite.id&.to_s == 'tls' }