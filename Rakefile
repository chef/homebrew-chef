require "net/http"
require "uri"

begin
  require "chefstyle"
  require "rubocop/rake_task"
  desc "Run Chefstyle tests"
  RuboCop::RakeTask.new(:style) do |task|
    task.options += ["--display-cop-names", "--no-color"]
  end
rescue LoadError
  puts "chefstyle gem is not installed. bundle install first to make sure all dependencies are installed."
end

module HomebrewChef
  class CaskUpdater
    CASK_CONFIG = {
      "chef-infra-client" => {
        cask_file: "Casks/chef-infra-client.rb",
        channel: "current",
        product_name: "chef",
        architectures: [
          { architecture: "arm64", platform_version: "13" },
        ],
        update_urls: true,
      }.freeze,
      "chef-workstation" => {
        cask_file: "Casks/chef-workstation.rb",
        channel: "stable",
        product_name: "chef-workstation",
        architectures: [
          { architecture: "x86_64", platform_version: "10.15" },
          { architecture: "arm64", platform_version: "11" },
        ],
        update_urls: false,
      }.freeze,
      "inspec" => {
        cask_file: "Casks/inspec.rb",
        channel: "stable",
        product_name: "inspec",
        architectures: [
          { architecture: "x86_64", platform_version: "12" },
        ],
        update_urls: true,
      }.freeze,
    }.freeze

    OMNITRUCK_BASE = "https://omnitruck.chef.io".freeze

    def initialize(product, version)
      @product = product
      @version = version
      @config = CASK_CONFIG.fetch(product) do
        raise ArgumentError, "Unknown product '#{product}'. Supported products: #{CASK_CONFIG.keys.join(", ")}"
      end
    end

    def run
      entries = fetch_metadata_entries
      update_cask_file(entries)
      puts "Updated #{@config[:cask_file]} to version #{@version}"
    end

    private

    def fetch_metadata_entries
      @config[:architectures].map do |arch_config|
        fetch_metadata_for_architecture(arch_config)
      end
    end

    def fetch_metadata_for_architecture(arch_config)
      uri = metadata_uri(arch_config)
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        raise "Failed to download metadata for '#{@product}' version '#{@version}' (#{arch_config[:architecture]}): #{response.code} #{response.message}"
      end

      metadata = parse_metadata(response.body)
      sha = metadata.fetch("sha256") do
        raise "Metadata did not include a sha256 value for '#{@product}' version '#{@version}' (#{arch_config[:architecture]})"
      end
      url = metadata["url"]

      {
        architecture: arch_config[:architecture],
        platform_version: arch_config[:platform_version],
        sha256: sha,
        url: url,
      }
    end

    def metadata_uri(arch_config)
      URI.parse(
        [
          OMNITRUCK_BASE,
          @config[:channel],
          @config[:product_name],
          "metadata?p=mac_os_x&pv=#{arch_config[:platform_version]}&m=#{arch_config[:architecture]}&v=#{@version}",
        ].join("/")
      )
    end

    def parse_metadata(metadata_body)
      metadata_body.each_line.with_object({}) do |line, metadata|
        next if line.strip.empty?

        key, value = line.split(/\s+/, 2)
        metadata[key] = value&.strip
      end
    end

    def update_cask_file(entries)
      path = @config[:cask_file]
      contents = File.read(path)

      sha_regex = /sha256\s+"[0-9a-f]{64}"/i
      sha_occurrences = contents.scan(sha_regex)
      if sha_occurrences.size < entries.size
        raise "Expected at least #{entries.size} sha256 entries in #{path}, found #{sha_occurrences.size}"
      end

      updated_contents = contents.sub(/version\s+"[^"]+"/, "version \"#{@version}\"")

      updated_contents = replace_occurrences(updated_contents, sha_regex, entries) do |entry, _match|
        "sha256 \"#{entry[:sha256]}\""
      end

      if @config[:update_urls]
        url_regex = /url\s+"([^"]+)"/
        url_occurrences = updated_contents.scan(url_regex)
        if url_occurrences.size < entries.size
          raise "Expected at least #{entries.size} url entries in #{path}, found #{url_occurrences.size}"
        end

        updated_contents = replace_occurrences(updated_contents, url_regex, entries) do |entry, match|
          current_url = match[1]
          replacement_url = build_url(entry[:url], current_url)
          "url \"#{replacement_url}\""
        end
      end

      File.write(path, updated_contents)
    end

    def build_url(new_url, current_url)
      return new_url unless current_url.include?('#{version}')

      new_url.gsub(@version, '#{version}')
    end

    def replace_occurrences(contents, regex, entries)
      index = 0
      contents.gsub(regex) do
        match = Regexp.last_match
        if index < entries.size
          replacement = yield(entries[index], match)
          index += 1
          replacement
        else
          match[0]
        end
      end
    end
  end
end

namespace :cask do
  desc "Update a Homebrew cask sha256 and version. Usage: rake cask:update[chef-infra-client,18.8.54]"
  task :update, %i{product version} do |_, args|
    product = args[:product]&.strip
    version = args[:version]&.strip

    unless product && version
      raise ArgumentError, "Usage: rake cask:update[product,version]"
    end

    HomebrewChef::CaskUpdater.new(product, version).run
  end
end

task default: %i{style}
