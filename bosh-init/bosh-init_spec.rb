require 'spec_helper'
require 'docker'
require 'serverspec'

BOSH_INIT_PACKAGES = "wget libc6-compat bash openssl build-base"
BOSH_INIT_VERSION = "0.0.100-a5c1605-2017-02-14T23:33:52Z"

describe "bosh-init image" do
  before(:all) {
    set :docker_image, find_image_id('bosh-init:latest')
  }

  it "installs the right version of Alpine Linux" do
    expect(os_version).to include("Alpine Linux 3.4")
  end

  def os_version
    command("cat /etc/issue | head -1").stdout
  end

  it "installs required packages" do
    BOSH_INIT_PACKAGES.split(' ').each do |package|
      expect(package(package)).to be_installed
    end
  end

  it "installs the expected version of bosh-init" do
    expect(
      command("bosh-init --version").stdout.strip
    ).to eq("version #{BOSH_INIT_VERSION}")
  end

  it "contains the compiled CPI packages" do
    installation_path = '/root/.bosh_init/installations/44f01911-a47a-4a24-6ca3-a3109b33f058'
    packages_file = file("#{installation_path}/compiled_packages.json")
    expect(packages_file).to exist
    compiled_packages = JSON.parse(packages_file.content)
    compiled_packages.each do |package|
      expect(file("#{installation_path}/blobs/#{package["Value"]["BlobID"]}")).to exist
    end

    cpi_package = compiled_packages.find {|p| p["Key"]["PackageName"] == "bosh_aws_cpi" }
    expect(cpi_package).to be

    expect(file("#{installation_path}/packages/bosh_aws_cpi/bin/aws_cpi")).to be_executable
  end
end
