require 'yaml'

# 0. Load secrets from local YAML file
if File.exist?("secrets.yml")
  secrets = YAML.load_file("secrets.yml")
else
  # Fallback values so Vagrant doesn't error out if file is missing
  secrets = { "rh_username" => "NOT_SET", "rh_password" => "NOT_SET" }
end

# Vagrantfile
Vagrant.configure("2") do |config|
  # 1. The Box: RHEL 9 (Generic)
  config.vm.box = "generic/rhel9"

  # 2. VM Hardware Config (Libvirt/KVM)
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 2048    # 2GB RAM
    libvirt.cpus = 2         # 2 vCPUs
    libvirt.driver = "kvm"   # Force KVM driver
  end

  # 3. Network: Private IP for easy access
  config.vm.network "private_network", ip: "192.168.56.10"

  # 4. Ansible Provisioning
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"

    # Map the VM to the 'rhel_hosts' group so your playbook works
    ansible.groups = {
      "rhel_hosts" => ["default"]
    }

    # Path to your playbook
    ansible.playbook = "playbooks/configuration/baseline.yml"
    # ansible.playbook = "playbooks/configuration/baseline-orig.yml"
    
    # Run as root (sudo)
    ansible.become = true
    
    # Explicitly tell Ansible this is a REAL VM (enables Services, Firewalls, Time)
    ansible.extra_vars = {
      "is_test_container" => false,
      "is_vagrant_env" => true,
      "rh_username" => secrets["rh_username"],
      "rh_password" => secrets["rh_password"]
    }
    
    # Run against all hosts found in the inventory/vagrant setup
    ansible.limit = "all"
    # This tells Ansible to look at both the Vagrant inventory AND your local inventory folder
    ansible.raw_arguments = [
      "--inventory", "#{File.dirname(__FILE__)}/inventory/"
    ]
  end
end
