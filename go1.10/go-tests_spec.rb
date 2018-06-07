require 'spec_helper'
require 'docker'
require 'serverspec'

GO_VERSION="1.10.2"
CF_CLI_VERSION="6.36.0"
LOG_CACHE_CLI_VERSION="1.1.0"

describe "cf-acceptance-tests image" do
  before(:all) {
    set :docker_image, find_image_id('go1.10:latest')
  }

  it "has the expected version of Go" do
    expect(
      command("go version").stdout
    ).to match(/go version go#{GO_VERSION}/)
  end

  it "has godep available" do
    expect(
      command("godep version").exit_status
    ).to eq(0)

  end

  it "has Ginkgo available" do
    expect(
      command("ginkgo version").exit_status
    ).to eq(0)

  end
end
