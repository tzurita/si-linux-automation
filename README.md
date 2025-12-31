# Smithsonian Linux Infrastructure Automation

This repository contains the Infrastructure as Code (IaC) for managing the Smithsonian Institution's RHEL server fleet. It is optimized for execution via **Red Hat Ansible Automation Platform (AAP) 2.6** and local development using **ansible-navigator**.

## 📂 Repository Structure

The project follows a modular design, separating environmental variables from core logic wrappers.

```text
.
├── Containerfile           # Definition for the Execution Environment (EE)
├── Vagrantfile             # Local development environment
├── ansible.cfg             # Local Ansible configuration
├── ansible-navigator.yml   # Navigator settings for EE integration
├── inventory/
│   ├── hosts.yml           # Inventory definition (Vagrant/Prod/NonProd)
│   └── group_vars/all/     # Modular baseline variables
│       ├── foundation.yml  # Phase 1: Repos, EPEL, DNF-Auto
│       ├── connectivity.yml# Phase 3: SSHD, Firewall, Postfix
│       ├── services.yml    # Phase 4: Cron, NRPE
│       ├── security.yml    # Phase 5: Splunk, Auditd, ClamAV
│       ├── compliance.yml  # Phase 6: CIS config, Crypto Policies
│       └── finalize.yml    # Phase 7: Users, Dotfiles, Dev Env
├── playbooks/
│   ├── configuration/      # Baseline configuration (baseline.yml)
│   ├── provisioning/       # Day 0: VM creation & Kickstart
│   ├── operations/         # Day 2: Patching & Maintenance
│   └── adhoc/              # Troubleshooting & one-off tasks
├── roles/                  # Internal logic (si_ prefix)
│   ├── si_foundation
│   ├── si_connectivity
│   ├── si_services
│   ├── si_security
│   └── si_finalize
└── molecule/               # Testing frameworks for role validation
