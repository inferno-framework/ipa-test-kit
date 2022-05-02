require_relative '../../must_support_test'

module IpaTestKit
  class OxygenSatMustSupportTest < Inferno::Test
    include IpaTestKit::MustSupportTest

    title 'All must support elements are provided in the Observation resources returned'
    description %(
      IPA Responders SHALL be capable of populating all data elements as
      part of the query results as specified by the IPA Server Capability
      Statement. This test will look through the Observation resources
      found previously for the following must support elements:

      * Observation.category
      * Observation.category.coding
      * Observation.category.coding.code
      * Observation.category.coding.system
      * Observation.category:VSCat
      * Observation.code
      * Observation.code.coding
      * Observation.code.coding.code
      * Observation.code.coding.system
      * Observation.code.coding:OxygenSatCode
      * Observation.component
      * Observation.component.code
      * Observation.component.code.coding.code
      * Observation.component.code.coding.code
      * Observation.component.value[x]
      * Observation.component.value[x].code
      * Observation.component.value[x].code
      * Observation.component.value[x].system
      * Observation.component.value[x].unit
      * Observation.component.value[x].value
      * Observation.component:Concentration
      * Observation.component:FlowRate
      * Observation.effective[x]
      * Observation.status
      * Observation.subject
      * Observation.value[x]
      * Observation.value[x].code
      * Observation.value[x].system
      * Observation.value[x].unit
      * Observation.value[x].value
      * Observation.value[x]:valueQuantity
    )

    id :ipa_010_oxygensat_must_support_test

    def resource_type
      'Observation'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
    end

    def scratch_resources
      scratch[:oxygensat_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
