require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'

module IpaTestKit
  class Generator
    class IGMetadataExtractor
      attr_accessor :ig_resources, :metadata, :base_search_params

      def initialize(ig_resources, base_search_params)
        self.ig_resources = ig_resources
        self.base_search_params = base_search_params
        add_missing_supported_profiles
        remove_extra_supported_profiles
        self.metadata = IGMetadata.new
      end

      def extract
        add_metadata_from_ig
        add_metadata_from_resources
        metadata
      end

      def add_metadata_from_ig
        metadata.ig_version = "v#{ig_resources.ig.version}"
      end

      def resources_in_capability_statement
        ig_resources.capability_statement.rest.first.resource
      end

      def add_missing_supported_profiles
        ig_resources.capability_statement.rest.first.resource
          .find { |resource| resource.type == 'Observation' }
          .supportedProfile.concat [
            'http://hl7.org/fhir/StructureDefinition/vitalsigns'
          ]
      end

      def remove_extra_supported_profiles
        ig_resources.capability_statement.rest.first.resource
            .find { |resource| resource.type == 'Observation' }
            .supportedProfile.delete_if do |profile_url|
              SpecialCases::PROFILES_TO_EXCLUDE.include?(profile_url)
            end
      end

      def add_metadata_from_resources
        metadata.groups =
          resources_in_capability_statement.flat_map do |resource|
            ([resource.profile] + resource.supportedProfile).uniq&.map do |supported_profile|
              GroupMetadataExtractor.new(resource, supported_profile, metadata, ig_resources, base_search_params).group_metadata
            end.compact
          end

        metadata.postprocess_groups(ig_resources)
      end
    end
  end
end
