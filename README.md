# Deploy NSX-T Infrastructure - Simple Topology



by Nicolas MICHEL [@vpackets](https://twitter.com/vpackets) / [LinkedIn](https://www.linkedin.com/in/mclnicolas/) 

_**This disclaimer informs readers that the views, thoughts, and opinions expressed in this series of posts belong solely to the author, and not necessarily to the author’s employer, organization, committee or other group or individual.**_

## Introduction

The purpose of this entire repository is to automate the deployment of an NSX-T infrastructure.

### Infrastructure Deployed

This repository will deploy the following virtual machines:

- 1x NSX-T Manager
- 6x NSX-T Edge (4 Used in the topology + 2 unused for random testing)
____

This repository will configure the following on NSX-T:
- NSX-T: Compute Manager
- NSX-T: License
- NSX-T: Uplink Profiles
- NSX-T: IP Pools
- NSX-T: Transport Zones
- NSX-T: Transport Zones Profiles
- NSX-T: Transport Nodes
- NSX-T: Edge Clusters
____

### Topology used

This topology will be used in this particular example:

![BGP P2P Topology](https://github.com/vmware-nsx/sddc-demos/blob/main/02-Deploy-NSXT-Topologies/01-BGP-P2P/NSX-T%20BGP%20P2P%20Topology.png)

#### Simple Topology

This topology will deploy 2 T0 installed on 4 different edge nodes.


Tenant 01:
- 1x T0 will be installed on Edge node 01 and Edge node 02 [Edge Cluster 01]
  - HA Mode: Active / Standby - Preemption
  - No statefull services
  - BGP Route Redistribution:
    - no Prefix list
    - T0: Redistributing Static routes
    - T0: Redistributing Connected routes (Service Interface / Loopback / Router link / External Interface Subnet)
    - T1: Redistributing Connected routes (Service Interface / Loopback / Router link / External Interface Subnet)
  - Tenant 01 IPv4 and IPv6 Segments :
    - Web: 10.1.1.0/24 - 2001:0010:0001:0001::/64
    - App: 10.1.2.0/24 - 2001:0010:0001:0002::/64
    - DB : 10.1.3.0/24 - 2001:0010:0001:0003::/64
 


Tenant 02:
- 1x T0 will be installed on Edge node 03 and Edge node 04 [Edge Cluster 02]
  - HA Mode: Active / Active
  - No statefull services
  - BGP Route Redistribution:
    - no Prefix list
    - T0: Redistributing Static routes
    - T0: Redistributing Connected routes (Service Interface / Loopback / Router link / External Interface Subnet)
    - T1: Redistributing Connected routes (Service Interface / Loopback / Router link / External Interface Subnet)
  - Tenant 01 IPv4 and IPv6 Segments :
    - Web: 10.1.1.0/24 - 2001:0010:0001:0001::/64
    - App: 10.1.2.0/24 - 2001:0010:0001:0002::/64
    - DB : 10.1.3.0/24 - 2001:0010:0001:0003::/64
 


# Deployment

## 01 - Deploy NSX-T Infrastructure - Ansible

In this playbook Ansible will deploy and configure the following:
 - One NSX-T Manager.

Modifying the value in the answerfile is mandatory or use a secure Vault

```zsh Ansible Code
ansible-playbook ./00-Infrastructure-NSXT/deploy-nsxt-manager.yml
```



## 02 - vCenter Registration to the NSX-T Manager - REST API

In this task, vCenter will be registered to the NSX-T manager using REST API

URL and Authentication need to be provided in the nsxt_parameters.py file

```zsh Bash Code
/usr/bin/python3 ./02-Configure-NSXT-Global/nsxt_infra_compute_manager_register.py
/usr/bin/python3 ./02-Configure-NSXT-Global/nsxt_infra_compute_manager_verify.py
```


## 03 - NSX-T Basic Configuration - Ansible

In this task, the following will be configured on the NSX-T Manager:

 - Configure the NSX-T License
 - Configure the IP Pool
 - Configure the Transport Zone
 - Confgiure the Transport node Profile
 - Deploy NSX-T on all hypervisors in a particular cluster.

Modifying the value in the answerfile is mandatory or use a secure Vault

```zsh Bash Code
ansible-playbook ./00-Infrastructure-NSXT/deploy-nsxt-infra.yml
```




## 03 - NSX-T IPv6 / MTU / EVPN Pool / BFD Profile / Edge Cluster Profile

In this task, the following will be configured on the NSX-T Manager:

 - Enable IPv6 in NSX-T
 - Set MTU to 9000 in NSX-T
 - Set an EVPN Pool (for future use)
 - Set BFD Profile for VM and BM edge nodes
 - Create the edge cluster profiles.


Modifying the value in the answerfile is mandatory or use a secure Vault

```zsh Bash Code
ansible-playbook ./00-Infrastructure-NSXT/deploy-edges.yml
```



## 04 - Deploy Edges - ANSIBLE

6 Edges nodes will be deployed in this topology

URL and Authentication need to be provided in the nsxt_parameters.py file

```zsh Bash Code
ansible-playbook ./00-Infrastructure-NSXT/deploy-edges.yml
```

## 05 - Create VM Template

Please refer to the following repo:  https://github.com/cloudmaniac/packer-templates

## 06 - Deploy Virtual Machines

Please refer to the following repo:  https://github.com/cloudmaniac/terraform-deploy-vmware-vm













## Notes 
User must configure answerfile.yml and provide credential/URL for the Python scripts to work