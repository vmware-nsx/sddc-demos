# Variables
# NSX Manager

variable "nsx_manager" {
    default = "srv-nsxt-manager-01.megasp.net"
}

# Username & Password for NSX-T Manager

    variable "username" {
    default = "admin"
}

variable "password" {
    default = "Mamigue1402@@Mamigue1402@@"
}

# Enter Edge Nodes Display Name. Required for external interfaces.

variable "edge_node_01" {
    default = "SRV-EDGE-01"
}
variable "edge_node_02" {
    default = "SRV-EDGE-02"
}

variable "edge_node_03" {
    default = "SRV-EDGE-03"
}
variable "edge_node_04" {
    default = "SRV-EDGE-04"
}

variable "edge_cluster_01" {
    default = "Edge-Cluster-01"
}

variable "edge_cluster_02" {
    default = "Edge-Cluster-02"
}

# Transport Zones Variables

variable "tz_overlay" {
    default = "TZ-Overlay"
}

variable "tz_vlan" {
    default = "TZ-VLAN"
}


# Internal Transit Subnets:

variable "internal_transit_subnets" {
    default = "169.254.0.0/24"
}

variable "transit_subnets" {
    default = "100.64.0.0/16"
}




# BGP Variables

variable "bgp_allow_as_in" {
    default = true
}

variable "tier0_edge_cluster_01_local_as" {
    default = "65000"
}

variable "tier0_edge_cluster_02_local_as" {
    default = "65001"
}

variable "bgp_password" {
    default = "VMwareBGP"
}

variable "bfd_status" {
    default = true
}

variable "bfd_interval" {
    default = 500
}

variable "bfd_multiple" {
    default = 3
}

variable "bgp_tor01_remote_as" {
    default = "65100"
}

variable "bgp_tor02_remote_as" {
    default = "65200"
}

variable "bgp_tor03_remote_as" {
    default = "65101"
}

variable "bgp_tor04_remote_as" {
    default = "65201"
}

variable "bgp_tor01_vlan10_ipv4" {
    default = "172.16.10.1"
}

variable "bgp_tor01_vlan11_ipv4" {
    default = "172.16.11.1"
}

variable "bgp_tor02_vlan12_ipv4" {
    default = "172.16.12.1"
}

variable "bgp_tor02_vlan13_ipv4" {
    default = "172.16.13.1"
}

variable "bgp_tor01_vlan10_ipv6" {
    default = "2001:172:16:10::10"
}

variable "bgp_tor01_vlan11_ipv6" {
    default = "2001:172:16:11::10"
}

variable "bgp_tor02_vlan12_ipv6" {
    default = "2001:172:16:12::10"
}

variable "bgp_tor02_vlan13_ipv6" {
    default = "2001:172:16:13::10"
}

variable "bgp_tor03_vlan20_ipv4" {
    default = "172.16.20.1"
}

variable "bgp_tor03_vlan21_ipv4" {
    default = "172.16.21.1"
}

variable "bgp_tor04_vlan22_ipv4" {
    default = "172.16.22.1"
}

variable "bgp_tor04_vlan23_ipv4" {
    default = "172.16.23.1"
}

variable "bgp_tor03_vlan20_ipv6" {
    default = "2001:172:16:20::10"
}

variable "bgp_tor03_vlan21_ipv6" {
    default = "2001:172:16:21::10"
}

variable "bgp_tor04_vlan22_ipv6" {
    default = "2001:172:16:22::10"
}

variable "bgp_tor04_vlan23_ipv6" {
    default = "2001:172:16:23::10"
}
# MTU

variable "tier0_interface_mtu" {
    default = "9000"
}


# Segment Names
variable "nsx_segment_web" {
    default = "VM-Segment-Web"
}
variable "nsx_segment_app" {
    default = "VM-Segment-App"
}

variable "nsx_segment_db" {
    default = "VM-Segment-DB"
}

# Security Group names. 
variable "nsx_group_web" {
    default = "Web Servers"
}

variable "nsx_group_app" {
    default = "App Servers"
}

variable "nsx_group_db" {
    default = "DB Servers"
}

variable "nsx_group_blue" {
    default = "Blue Application"
}

variable "nsx_group_red" {
    default = "Red Application"
}



