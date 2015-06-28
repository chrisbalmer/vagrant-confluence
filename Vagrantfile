# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "confluence" do |confluence|
    confluence.vm.box = "vagrant-rhel71-x64"
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# VMware Config
#
################################################################################
    confluence.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = 1024
    end
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# Network Config
#
################################################################################
    confluence.vm.hostname = "confluence.labs.oaksec.io"

    # Default SSH port should be 22
    # However some salt states might change this port
    # Update as needed for your lab
    confluence.ssh.port = 22
    confluence.vm.network "forwarded_port",
              guest: 8090,
              host: 8090,
              auto_correct: true
    confluence.vm.network "private_network",
              ip: "192.168.211.65",
              netmask: "255.255.255.0"

    # Required for CentOS 7/RHEL and a private_network static IP
    confluence.vm.provision "shell",
              inline: <<-SHELL
      sudo systemctl restart NetworkManager
      sudo systemctl restart network
    SHELL
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# RHEL Config (If box is RHEL)
#
################################################################################
    confluence.vm.provision "shell",
              run: "always",
              inline: <<-SHELL
      if grep -q 'ID="rhel"' "/etc/os-release"; then
        sudo subscription-manager repos --enable rhel-7-server-optional-rpms
        sudo subscription-manager repos --enable rhel-7-server-extras-rpms
      fi
    SHELL
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# Salt Config
#
################################################################################
    confluence.vm.provision :salt do |config|
      config.install_type = "stable"
      config.bootstrap_options = ""
      config.temp_config_dir = "/tmp"
      config.minion_config = "etc/salt/minion"
      config.verbose = false
      config.run_highstate = false
    end
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# Sync Data Folders
#
################################################################################
    #confluence.vm.synced_folder "opt/atlassian/confluence/",
    #                            "/opt/atlassian/confluence/"
    confluence.vm.synced_folder "confluence/",
                                "/var/atlassian/application-data/confluence/"
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
#
# Confluence Install
#
################################################################################
    confluence.vm.provision "shell",
                            path: "install-confluence.sh"
  end
end
