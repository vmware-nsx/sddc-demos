# Terraform Provider
terraform {
    required_providers {
        nsxt = {
            source = "vmware/nsxt"
            version = "3.2.5"
            }
            }
            }

############################
#  NSX-T Manager - Provider#
############################

provider "nsxt" {
    host                     = var.nsx_manager
    username                 = var.username
    password                 = var.password
    allow_unverified_ssl     = true
    max_retries              = 10
    retry_min_delay          = 500
    retry_max_delay          = 5000
    retry_on_status_codes    = [429]
}

#################
#  Data Sources #
#################

data "nsxt_policy_transport_zone" "tz_overlay" {
    display_name = var.tz_overlay
}

data "nsxt_policy_transport_zone" "tz_vlan" {
    display_name = var.tz_vlan
}

data "nsxt_policy_edge_node" "edge_node_01" {
    edge_cluster_path   = data.nsxt_policy_edge_cluster.edge_cluster_01.path
    display_name        = var.edge_node_01
}

data "nsxt_policy_edge_node" "edge_node_02" {
    edge_cluster_path   = data.nsxt_policy_edge_cluster.edge_cluster_01.path
    display_name        = var.edge_node_02
}

data "nsxt_policy_edge_node" "edge_node_03" {
    edge_cluster_path   = data.nsxt_policy_edge_cluster.edge_cluster_02.path
    display_name        = var.edge_node_03
}

data "nsxt_policy_edge_node" "edge_node_04" {
    edge_cluster_path   = data.nsxt_policy_edge_cluster.edge_cluster_02.path
    display_name        = var.edge_node_04
}

data "nsxt_policy_edge_cluster" "edge_cluster_01" {
    display_name = var.edge_cluster_01
}

data "nsxt_policy_edge_cluster" "edge_cluster_02" {
    display_name = var.edge_cluster_02
}


######################
#  Vlan Segments     #
######################

resource "nsxt_policy_vlan_segment" "tier0_tor01_vlan_10" {
    display_name = "Uplink-TOR01-Vlan10"
    nsx_id = "Uplink-TOR01-Vlan10"    
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["10"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-1"
        }    
}

resource "nsxt_policy_vlan_segment" "tier0_tor01_vlan_11" {
    display_name = "Uplink-TOR01-Vlan11"
    nsx_id = "Uplink-TOR01-Vlan11"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["11"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-1"
        }    
}

resource "nsxt_policy_vlan_segment" "tier0_tor02_vlan_12" {
    display_name = "Uplink-TOR02-Vlan12"
    nsx_id = "Uplink-TOR02-Vlan12"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["12"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-2"
        }    
}

resource "nsxt_policy_vlan_segment" "tier0_tor02_vlan_13" {
    display_name = "Uplink-TOR02-Vlan13"
    nsx_id = "Uplink-TOR02-Vlan13"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["13"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-2"
        }    
}


resource "nsxt_policy_vlan_segment" "tier0_tor03_vlan_20" {
    display_name = "Uplink-TOR03-Vlan20"
    nsx_id = "Uplink-TOR03-Vlan20"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["20"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-1"
        }    
}

resource "nsxt_policy_vlan_segment" "tier0_tor03_vlan_21" {
    display_name = "Uplink-TOR03-Vlan21"
    nsx_id = "Uplink-TOR03-Vlan21"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["21"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-1"
        }        
}

resource "nsxt_policy_vlan_segment" "tier0_tor04_vlan_22" {
    display_name = "Uplink-TOR04-Vlan22"
    nsx_id = "Uplink-TOR04-Vlan22"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["22"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-2"
        }    
}

resource "nsxt_policy_vlan_segment" "tier0_tor04_vlan_23" {
    display_name = "Uplink-TOR04-Vlan23"
    nsx_id = "Uplink-TOR04-Vlan23"
    description = "VLAN Segment created by Terraform"
    transport_zone_path = data.nsxt_policy_transport_zone.tz_vlan.path
    vlan_ids = ["23"]
    advanced_config {
        connectivity = "ON"
        uplink_teaming_policy = "TOR-2"
        }    
}

#################
#  T0 Creation  #
#################

resource "nsxt_policy_tier0_gateway" "tier0_tenant01" {
    description               = "Tier0 provisioned by Terraform"
    display_name              = "Tier0-Tenant01"
    nsx_id                    = "Tier0-Tenant01"
    failover_mode             = "PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    #force_whitelisting        = true  Please use nsxt_policy_predefined_gateway_policy
    ha_mode                   = "ACTIVE_STANDBY"
    internal_transit_subnets  = [var.internal_transit_subnets]
    transit_subnets           = [var.transit_subnets]
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_01.path
    bgp_config {
        ecmp            = true  
        local_as_num    = var.tier0_edge_cluster_01_local_as
        inter_sr_ibgp   = false
        multipath_relax = true    
    }
    redistribution_config {
        enabled = true
        rule {
        name  = "T0-Default-Redistribution"
        types = ["TIER0_STATIC", "TIER0_CONNECTED", "TIER0_EVPN_TEP_IP", "TIER0_SERVICE_INTERFACE", "TIER0_LOOPBACK_INTERFACE", "TIER0_NAT", "TIER1_CONNECTED", "TIER1_STATIC","TIER1_LB_VIP", "TIER1_CONNECTED", "TIER1_SERVICE_INTERFACE", "TIER1_NAT", "TIER1_LB_SNAT"]
        }
    }
}

resource "nsxt_policy_tier0_gateway" "tier0_tenant02" {
    description               = "Tier0 provisioned by Terraform"
    display_name              = "Tier0-Tenant02"
    nsx_id                    = "Tier0-Tenant02"
    #failover_mode             = "PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    #force_whitelisting        = true  Please use nsxt_policy_predefined_gateway_policy
    ha_mode                   = "ACTIVE_ACTIVE"
    internal_transit_subnets  = [var.internal_transit_subnets]
    transit_subnets           = [var.transit_subnets]
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_02.path
    bgp_config {
        ecmp            = true  
        local_as_num    = var.tier0_edge_cluster_02_local_as
        inter_sr_ibgp   = true
        multipath_relax = true    
    }
    redistribution_config {
        enabled = true
        rule {
        name  = "T0-Default-Redistribution"
        types = ["TIER0_STATIC", "TIER0_CONNECTED", "TIER1_CONNECTED", "TIER1_LB_VIP", "TIER1_SERVICE_INTERFACE", "TIER1_NAT", "TIER1_LB_SNAT"]
        }
    }
}


###################
#  T0 Interfaces  #
###################


resource "nsxt_policy_tier0_gateway_interface" "tier0_en01_tor01_vlan10_interface" {
    display_name           = "EN01-TOR01-VLAN10"
    nsx_id                 = "EN01-TOR01-VLAN10"
    description            = "Uplink EN01 - TOR01"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_01.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor01_vlan_10.path
    subnets                = ["172.16.10.0/31","2001:172:16:10::1/122"]
    mtu                    = var.tier0_interface_mtu
}

resource "nsxt_policy_tier0_gateway_interface" "tier0_en01_tor02_vlan13_interface" {
    display_name           = "EN01-TOR02-VLAN13"
    nsx_id                 = "EN01-TOR02-VLAN13"
    description            = "Uplink EN01 - TOR02"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_01.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor02_vlan_13.path
    subnets                = ["172.16.13.0/31","2001:172:16:13::1/122"]
    mtu                    = var.tier0_interface_mtu
}


resource "nsxt_policy_tier0_gateway_interface" "tier0_en01_loopback_interface" {
    display_name           = "EN01-LOOPBACK"
    nsx_id                 = "EN01-LOOPBACK"
    description            = "EN01-LOOPBACK"
    type                   = "LOOPBACK"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_01.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    subnets                = ["1.1.1.1/32","2001:1:1:1::1/64"]
}





resource "nsxt_policy_tier0_gateway_interface" "tier0_en02_tor01_vlan11_interface" {
    display_name           = "EN02-TOR01-VLAN11"
    nsx_id                 = "EN02-TOR01-VLAN11"
    description            = "Uplink EN02 - TOR01"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_02.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor01_vlan_11.path
    subnets                = ["172.16.11.0/31","2001:172:16:11::2/122"]
    mtu                    = var.tier0_interface_mtu
}

resource "nsxt_policy_tier0_gateway_interface" "tier0_en02_tor02_vlan12_interface" {
    display_name           = "EN02-TOR02-VLAN12"
    nsx_id                 = "EN02-TOR02-VLAN12"
    description            = "Uplink EN02 - TOR02"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_02.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor02_vlan_12.path
    subnets                = ["172.16.12.0/31","2001:172:16:12::2/122"]
    mtu                    = var.tier0_interface_mtu
}

resource "nsxt_policy_tier0_gateway_interface" "tier0_en02_loopback_interface" {
    display_name           = "EN02-LOOPBACK"
    nsx_id                 = "EN02-LOOPBACK"
    description            = "EN02-LOOPBACK"
    type                   = "LOOPBACK"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_02.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant01.path
    subnets                = ["2.2.2.2/32","2001:2:2:2::2/64"]
}











resource "nsxt_policy_tier0_gateway_interface" "tier0_en03_tor03_vlan20_interface" {
    display_name           = "EN03-TOR03-VLAN11"
    nsx_id                 = "EN03-TOR03-VLAN11"
    description            = "Uplink EN03 - TOR03"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_03.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor03_vlan_20.path
    subnets                = ["172.16.20.0/31","2001:172:16:20::3/122"]
    mtu                    = var.tier0_interface_mtu
}


resource "nsxt_policy_tier0_gateway_interface" "tier0_en03_tor04_vlan23_interface" {
    display_name           = "EN03-TOR04-VLAN23"
    nsx_id                 = "EN03-TOR04-VLAN23"
    description            = "Uplink EN03 - TOR04"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_03.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor04_vlan_23.path
    subnets                = ["172.16.23.0/31","2001:172:16:23::3/122"]
    mtu                    = var.tier0_interface_mtu
}


resource "nsxt_policy_tier0_gateway_interface" "tier0_en03_loopback_interface" {
    display_name           = "EN03-LOOPBACK"
    nsx_id                 = "EN03-LOOPBACK"
    description            = "EN03-LOOPBACK"
    type                   = "LOOPBACK"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_03.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    subnets                = ["3.3.3.3/32","2001:3:3:3::3/64"]
}










resource "nsxt_policy_tier0_gateway_interface" "tier0_en04_tor03_vlan21_interface" {
    display_name           = "EN04-TOR03-VLAN21"
    nsx_id                 = "EN04-TOR03-VLAN21"
    description            = "Uplink EN04 - TOR03"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_04.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor03_vlan_21.path
    subnets                = ["172.16.21.0/31","2001:172:16:21::4/122"]
    mtu                    = var.tier0_interface_mtu
}

resource "nsxt_policy_tier0_gateway_interface" "tier0_en04_tor04_vlan22_interface" {
    display_name           = "EN04-TOR04-VLAN22"
    nsx_id                 = "EN04-TOR04-VLAN22"
    description            = "Uplink EN04 - TOR04"
    type                   = "EXTERNAL"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_04.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    segment_path           = nsxt_policy_vlan_segment.tier0_tor04_vlan_22.path
    subnets                = ["172.16.22.0/31","2001:172:16:22::4/122"]
    mtu                    = var.tier0_interface_mtu
}


resource "nsxt_policy_tier0_gateway_interface" "tier0_en04_loopback_interface" {
    display_name           = "EN04-LOOPBACK"
    nsx_id                 = "EN04-LOOPBACK"
    description            = "EN04-LOOPBACK"
    type                   = "LOOPBACK"
    edge_node_path         = data.nsxt_policy_edge_node.edge_node_04.path
    gateway_path           = nsxt_policy_tier0_gateway.tier0_tenant02.path
    subnets                = ["4.4.4.4/32","2001:4:4:4::4/64"]
}








##################
#  BGP Neighbor  #
##################

resource "nsxt_policy_bgp_neighbor" "TOR-01-IPv4-VLAN10" {
    display_name        = "TOR-01-IPv4-VLAN10"
    nsx_id              = "TOR-01-IPv4-VLAN10"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor01_vlan10_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor01_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en01_tor01_vlan10_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-01-IPv4-VLAN11" {
    display_name        = "TOR-01-IPv4-VLAN-11"
    nsx_id              = "TOR-01-IPv4-VLAN-11"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor01_vlan11_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor01_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en02_tor01_vlan11_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-02-IPv4-VLAN12" {
    display_name        = "TOR-02-IPv4-VLAN12"
    nsx_id              = "TOR-02-IPv4-VLAN12"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor02_vlan12_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor02_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en02_tor02_vlan12_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-02-IPv4-VLAN13" {
    display_name        = "TOR-02-IPv4-VLAN13"
    nsx_id              = "TOR-02-IPv4-VLAN13"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor02_vlan13_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor02_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en01_tor02_vlan13_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-01-IPv6-VLAN10" {
    display_name        = "TOR-01-IPv6-VLAN10"
    nsx_id              = "TOR-01-IPv6-VLAN10"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor01_vlan10_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor01_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en01_tor01_vlan10_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-01-IPv6-VLAN11" {
    display_name        = "TOR-01-IPv6-VLAN11"
    nsx_id              = "TOR-01-IPv6-VLAN11"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor01_vlan11_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor01_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en02_tor01_vlan11_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-02-IPv6-VLAN12" {
    display_name        = "TOR-02-IPv6-VLAN12"
    nsx_id              = "TOR-02-IPv6-VLAN12"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor02_vlan12_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor02_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en02_tor02_vlan12_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-02-IPv6-VLAN13" {
    display_name        = "TOR-02-IPv6-VLAN13"
    nsx_id              = "TOR-02-IPv6-VLAN13"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant01.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor02_vlan13_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor02_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en01_tor02_vlan13_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}


resource "nsxt_policy_bgp_neighbor" "TOR-03-IPv4-VLAN20" {
    display_name        = "TOR-03-IPv4-VLAN20"
    nsx_id              = "TOR-03-IPv4-VLAN20"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor03_vlan20_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor03_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en03_tor03_vlan20_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-03-IPv4-VLAN21" {
    display_name        = "TOR-03-IPv4-VLAN21"
    nsx_id              = "TOR-03-IPv4-VLAN21"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor03_vlan21_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor03_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en04_tor03_vlan21_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-04-IPv4-VLAN22" {
    display_name        = "TOR-04-IPv4-VLAN22"
    nsx_id              = "TOR-04-IPv4-VLAN22"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor04_vlan22_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor04_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en04_tor04_vlan22_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-04-IPv4-VLAN23" {
    display_name        = "TOR-04-IPv4-VLAN23"
    nsx_id              = "TOR-04-IPv4-VLAN23"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor04_vlan23_ipv4
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor04_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en03_tor04_vlan23_interface.ip_addresses[0]]
    route_filtering {
        address_family = "IPV4"
        }
    route_filtering {
        address_family = "L2VPN_EVPN"
        }
    bfd_config {
    enabled  = var.bfd_status
    interval = var.bfd_interval
    multiple = var.bfd_multiple
    }
}

resource "nsxt_policy_bgp_neighbor" "TOR-03-IPv6-VLAN20" {
    display_name        = "TOR-03-IPv6-VLAN20"
    nsx_id              = "TOR-03-IPv6-VLAN20"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor03_vlan20_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor03_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en03_tor03_vlan20_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-03-IPv6-VLAN21" {
    display_name        = "TOR-03-IPv6-VLAN21"
    nsx_id              = "TOR-03-IPv6-VLAN21"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor03_vlan21_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor03_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en04_tor03_vlan21_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-04-IPv6-VLAN22" {
    display_name        = "TOR-04-IPv6-VLAN22"
    nsx_id              = "TOR-04-IPv6-VLAN22"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor04_vlan22_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor04_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en04_tor04_vlan22_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}

resource "nsxt_policy_bgp_neighbor" "TOR-04-IPv6-VLAN23" {
    display_name        = "TOR-04-IPv6-VLAN23"
    nsx_id              = "TOR-04-IPv6-VLAN23"
    description         = "Terraform provisioned BGP Neighbor Configuration"
    bgp_path            = nsxt_policy_tier0_gateway.tier0_tenant02.bgp_config.0.path
    allow_as_in         = var.bgp_allow_as_in
    neighbor_address    = var.bgp_tor04_vlan23_ipv6
    password            = var.bgp_password
    remote_as_num       = var.bgp_tor04_remote_as
    source_addresses    = [nsxt_policy_tier0_gateway_interface.tier0_en03_tor04_vlan23_interface.ip_addresses[1]]
    route_filtering {
        address_family = "IPV6"
        }
    #bfd_config {
    #enabled  = true
    #interval = 500
    #multiple = 3
    #}
}





#################
#  T1 Creation  #
#################
resource "nsxt_policy_tier1_gateway" "tier1_tenant01" {
    description               = "Tier1 provisioned by Terraform"
    display_name              = "Tier1-Tenant01"
    nsx_id                    = "Tier1-Tenant01"
    failover_mode             = "NON_PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    enable_standby_relocation = false
    #force_whitelisting        = "true"
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_01.path
    tier0_path                = nsxt_policy_tier0_gateway.tier0_tenant01.path
    route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]


    #route_advertisement_rule {
    #    name                      = "Tier1 - IPv4 Prefixes"
    #    action                    = "PERMIT"
    #    subnets                   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24". "2001:10:1:1::0/64", "2001:10:1:2::0/64", "2001:10:1:3::0/64"]
    #    prefix_operator           = "GE"
    #    route_advertisement_types = ["TIER1_CONNECTED"]
    #}
}


resource "nsxt_policy_tier1_gateway" "tier1_tenant02" {
    description               = "Tier1 provisioned by Terraform"
    display_name              = "Tier1-Tenant02"
    nsx_id                    = "Tier1-Tenant02"
    failover_mode             = "NON_PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    enable_standby_relocation = false
    #force_whitelisting        = "true"
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_02.path
    tier0_path                = nsxt_policy_tier0_gateway.tier0_tenant02.path
    route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]


    #route_advertisement_rule {
    #    name                      = "Tier1 - IPv4 Prefixes"
    #    action                    = "PERMIT"
    #    subnets                   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24". "2001:10:1:1::0/64", "2001:10:1:2::0/64", "2001:10:1:3::0/64"]
    #    prefix_operator           = "GE"
    #    route_advertisement_types = ["TIER1_CONNECTED"]
    #}
}

resource "nsxt_policy_tier1_gateway" "tier1_tenant03" {
    description               = "Tier1 provisioned by Terraform"
    display_name              = "Tier1-Tenant03"
    nsx_id                    = "Tier1-Tenant03"
    failover_mode             = "NON_PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    enable_standby_relocation = false
    #force_whitelisting        = "true"
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_01.path
    tier0_path                = nsxt_policy_tier0_gateway.tier0_tenant01.path
    route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]


    #route_advertisement_rule {
    #    name                      = "Tier1 - IPv4 Prefixes"
    #    action                    = "PERMIT"
    #    subnets                   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24". "2001:10:1:1::0/64", "2001:10:1:2::0/64", "2001:10:1:3::0/64"]
    #    prefix_operator           = "GE"
    #    route_advertisement_types = ["TIER1_CONNECTED"]
    #}
}

resource "nsxt_policy_tier1_gateway" "tier1_tenant04" {
    description               = "Tier1 provisioned by Terraform"
    display_name              = "Tier1-Tenant04"
    nsx_id                    = "Tier1-Tenant04"
    failover_mode             = "NON_PREEMPTIVE"
    default_rule_logging      = false
    enable_firewall           = false
    enable_standby_relocation = false
    #force_whitelisting        = "true"
    edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster_02.path
    tier0_path                = nsxt_policy_tier0_gateway.tier0_tenant02.path
    route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]


    #route_advertisement_rule {
    #    name                      = "Tier1 - IPv4 Prefixes"
    #    action                    = "PERMIT"
    #    subnets                   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24". "2001:10:1:1::0/64", "2001:10:1:2::0/64", "2001:10:1:3::0/64"]
    #    prefix_operator           = "GE"
    #    route_advertisement_types = ["TIER1_CONNECTED"]
    #}
}

######################
#  Overlay Segments  #
######################

resource "nsxt_policy_segment" "tenant01_web" {
    display_name        = "Tenant01-Web"
    nsx_id              = "Tenant01-Web"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant01.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.1.1.1/24"
        }
    subnet {
        cidr        = "2001:10:1:1::1/64"
        }
}

resource "nsxt_policy_segment" "tenant01_app" {
    display_name        = "Tenant01-App"
    nsx_id              = "Tenant01-App"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant01.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.1.2.1/24"
        }
    subnet {
        cidr        = "2001:10:1:2::1/64"
        }
}

resource "nsxt_policy_segment" "tenant01_db" {
    display_name        = "Tenant01-Db"
    nsx_id              = "Tenant01-Db"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant01.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.1.3.1/24"
        }
    subnet {
        cidr        = "2001:10:1:3::1/64"
        }
}

resource "nsxt_policy_segment" "tenant01_bridging" {
    display_name        = "Tenant01-Bridging"
    nsx_id              = "Tenant01-Bridging"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant01.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.10.10.1/24"
        }
    subnet {
        cidr        = "2001:10:10:10::1/64"
        }
}

resource "nsxt_policy_segment" "tenant02_web" {
    display_name        = "Tenant02-Web"
    nsx_id              = "Tenant02-Web"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant02.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.2.1.1/24"
        }
    subnet {
        cidr        = "2001:10:2:1::1/64"
        }
}

resource "nsxt_policy_segment" "tenant02_app" {
    display_name        = "Tenant02-App"
    nsx_id              = "Tenant02-App"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant02.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.2.2.1/24"
        }
    subnet {
        cidr        = "2001:10:2:2::1/64"
        }
}

resource "nsxt_policy_segment" "tenant02_db" {
    display_name        = "Tenant02-Db"
    nsx_id              = "Tenant02-Db"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant02.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.2.3.1/24"
        }
    subnet {
        cidr        = "2001:10:2:3::1/64"
        }
}








resource "nsxt_policy_segment" "tenant03_web" {
    display_name        = "Tenant03-Web"
    nsx_id              = "Tenant03-Web"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant03.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.3.1.1/24"
        }
    subnet {
        cidr        = "2001:10:3:1::1/64"
        }
}

resource "nsxt_policy_segment" "tenant03_app" {
    display_name        = "Tenant03-App"
    nsx_id              = "Tenant03-App"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant03.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.3.2.1/24"
        }
    subnet {
        cidr        = "2001:10:3:2::1/64"
        }
}

resource "nsxt_policy_segment" "tenant03_db" {
    display_name        = "Tenant03-Db"
    nsx_id              = "Tenant03-Db"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant03.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.3.3.1/24"
        }
    subnet {
        cidr        = "2001:10:3:3::1/64"
        }
}


resource "nsxt_policy_segment" "tenant04_web" {
    display_name        = "Tenant04-Web"
    nsx_id              = "Tenant04-Web"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant04.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.4.1.1/24"
        }
    subnet {
        cidr        = "2001:10:4:1::1/64"
        }
}

resource "nsxt_policy_segment" "tenant04_app" {
    display_name        = "Tenant04-App"
    nsx_id              = "Tenant04-App"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant04.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.4.2.1/24"
        }
    subnet {
        cidr        = "2001:10:4:2::1/64"
        }
}

resource "nsxt_policy_segment" "tenant04_db" {
    display_name        = "Tenant04-Db"
    nsx_id              = "Tenant04-Db"
    description         = "Terraform provisioned Segment"
    connectivity_path   = nsxt_policy_tier1_gateway.tier1_tenant04.path
    transport_zone_path = data.nsxt_policy_transport_zone.tz_overlay.path

    subnet {
        cidr        = "10.4.3.1/24"
        }
    subnet {
        cidr        = "2001:10:4:3::1/64"
        }
}


