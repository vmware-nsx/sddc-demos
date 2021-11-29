# vPackets - Deploy NSX-T Infrastructure - Simple Topology



by Nicolas MICHEL [@vpackets](https://twitter.com/vpackets) / [LinkedIn](https://www.linkedin.com/in/mclnicolas/) / [Blog](http://vpackets.net/) 

_**This disclaimer informs readers that the views, thoughts, and opinions expressed in this series of posts belong solely to the author, and not necessarily to the author’s employer, organization, committee or other group or individual.**_

## Introduction

The purpose of this entire repository is to automate the deployment of my NSX-T infrastructure in my lab.

### Infrastructure Deployed

This repository will deploy the following virtual machines:

- 1x NSX-T Manager
- 6x NSX-T Edge
- 5x Cumulus VX (4 Top of Rack and 1 Spine)
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

There are multiple topologies used in this repository:

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
    - Web: 10.1.1.0/24 - beef:0010:0001:0001::/64
    - App: 10.1.2.0/24 - beef:0010:0001:0002::/64
    - DB : 10.1.3.0/24 - beef:0010:0001:0003::/64
 


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
    - Web: 10.1.1.0/24 - beef:0010:0001:0001::/64
    - App: 10.1.2.0/24 - beef:0010:0001:0002::/64
    - DB : 10.1.3.0/24 - beef:0010:0001:0003::/64
 


### Code Tree


-----
-----



# Deployment

## 01 - Deploy NSX-T Manager

Only one NSX-T Manager will be deployed in this Lab environment.

## 02 - Configure Compute Manager

In the first task, the playbook will check if the vCenter is registered as a compute manager to the NSX-T Manager. Since the intent of this entire repository is to deploy a greenfield lab environment, this step is not necessary but it has been useful to run that task in some corner cases for my lab (hence why the code is still there).

The second task will register the vCenter as a computer manager to the NSX-T Manager.

## 03 - Add a license to the NSX-T Manager.

This playbook will configure a license (NSX Data Center Enterprise Plus)to the NSX-Manager.

## 04 - Configure the NSX-T Uplink Profiles.

2 uplink profiles will be created:

- Compute:
  - Default Teaming Policy for the TEP: PNIC-01 (uplink-1) and PNIC-02 (uplink-2)
  - Policy: Loadbalance Src ID
  - Vlan 110

- Edge:
  - Default Teaming Policy for the TEP: PNIC-01 (uplink-1) and PNIC-02 (uplink-2)
  - Policy: Loadbalance Src ID
  - Vlan 120
  - Named Teaming Policy: 
    - TOR-1 : 
      - Uplink-1
      - Failover Order
    - TOR-2 : 
      - Uplink-2
      - Failover Order

It is unnecessary to configure the MTU for the uplink profile as the MTU is handled at the vSphere level since we are using a VDS instead of an NVDS for the compute managers.


## 05 - Configure IP Pools

2 IP Pools are created for the TEP. One pool will be dedicated for the Compute Servers and one pool will be dedicated for the Edge Virtual Machines. It is totally supported to have all the TEPs in the same pool but I wanted to create 2 pools to demonstrate that Layer 3 between the compute and edge racks was a totally valid architecture for NSX-T

## 06 - Transport Zones:

2x Transport zones are created in this playbook. One transport zone is for the Overlay while the other one is a Vlan Transport zone.


## 07 - Configure the Transport Nodes Profile:

This playbook creates a Transport Node Profile for the compute hosts.
It is necessary when you want to configure all host in a cluster so that they leverage the same template. 

- Type: VDS
- Mode: Standard
- Compute Manager: vCenter
- VDS: ATX-VDS
- Transport Zone: Overlay (the compute hosts have no need to be part of the VLAN Transport Zone in this architecture)
- Uplink Profile: UP-Compute
- IP Assignement: 
  - IP pool:
    - IPPool-IPV4-TEP-COMPUTE
- Teaming Policy
  - uplink1 : dvUplink-1
  - uplink2 : dvUplink-2

## 08 - Configure the Transport Nodes:

This playbook will instal NSX-T on all the hosts that are part of the Compute cluster.

## 09 - Deploy the Edge Nodes:

This playbook will install several NSX-T Edge (6) to match the architecture needs.

- Form Factor: 
  - Medium
- Edge Switch Name: 
  - EDGE-NVDS
- Transport Zone:
  - Overlay (Inter Edge - Compute Traffic)
  - VLAN (Traffic exchanged with the physical fabric)
- Uplink Profile:
  - UP-Edge
- IP Assignement:
  - Use IP Pool
    - IPPool-IPV4-TEP-EDGE
- Teaming Policy
  - Uplink-1 : DPG-TRUNK-TOR-01
  - Uplink-2 : DPG-TRUNK-TOR-02


DPG Trunk TOR 01 has the following Teaming configuration (vSphere related):
- Active uplinks:
  - dvUplink1
- Standby uplinks:
  - dvUplink2 
- Unused uplinks:
  -  dvUplink3, dvUplink4 

DPG Trunk TOR 02 has the following Teaming configuration (vSphere related):
- Active uplinks:
  - dvUplink2
- Standby uplinks:
  - dvUplink1 
- Unused uplinks:
  -  dvUplink3, dvUplink4 

## 10 - Configure the Edge Clusters on the NSX-T Manager:

This playbook will group the edge nodes in pairs. The default nsx-default-edge-high-availability-profile will be used as it fulfill our needs (BFD Probe 500ms / BFD Declare dead 3)

- Edge cluster 01:
  - Edge node 01
  - Edge node 02

- Edge cluster 02:
  - Edge node 03
  - Edge node 04

- Edge cluster 03:
  - Edge node 05
  - Edge node 06

## 11 - Deploy Cumulus VX Top of Rack and Spine.:

This playbook will deploy 5 Cumulus VX. 
4 Cumulus VX will act as Top of Racks for the NSX-T Architecture. The remaining cumulus VX will be the Spine that will interconnect all the networks (physical and virtual).

## Running the main playbook

```sh
sudo ansible-playbook deploy.yml
```

# To Do List:

- Bring down the environment.
- Readme doc with links and images

## Timing
Time on my hardware: 1 hour and 51 minutes

## Notes 
The answerfile-json is here as an example and to check if I can improve the code using json instead of yml.