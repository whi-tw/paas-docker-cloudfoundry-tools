require 'spec_helper'
require 'docker'
require 'serverspec'

describe "cf-pats image" do
  before(:all) {
    set :docker_image, find_image_id('cf-pats:latest')
  }

  it "installs the right version of Alpine Linux" do
    expect(os_version).to include("Alpine Linux 3.3")
  end

  def os_version
    command("cat /etc/issue | head -1").stdout
  end

  it "checks if pat works" do
    expect(
      command("pat -h").stderr
    ).to include("Usage of pat")
  end

  it "has CF CLI available" do
    expect(
      command("cf -h").exit_status
    ).to eq(0)
  end

  it "has git available" do
    expect(
      command("git --version").exit_status
    ).to eq(0)
  end

  it "has bzr available" do
    expect(
      command("bzr -h").exit_status
    ).to eq(0)
  end
end
