require_relative '../../must_support_test'

module IpaTestKit
  class DeviceMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the Device resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the Device resources
      found previously for the following must support elements:

      * Device.distinctIdentifier
      * Device.expirationDate
      * Device.lotNumber
      * Device.manufactureDate
      * Device.patient
      * Device.serialNumber
      * Device.type
      * Device.udiCarrier
      * Device.udiCarrier.deviceIdentifier
    )

    id :ipa_010_device_must_support_test

    def resource_type
      'Device'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:device_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
