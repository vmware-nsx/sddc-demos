##### Provider
provider "vsphere" {
  user           = var.provider_vsphere_user
  password       = var.provider_vsphere_password
  vsphere_server = var.provider_vsphere_host

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

##### Data sources
data "vsphere_datacenter" "target_dc" {
  name = var.deploy_vsphere_datacenter
}

data "vsphere_datastore" "target_datastore" {
  name          = var.deploy_vsphere_datastore
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_compute_cluster" "target_cluster" {
  name          = var.deploy_vsphere_cluster
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant01_web" {
  name          = var.deploy_vsphere_network_tenant01_web
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant01_app" {
  name          = var.deploy_vsphere_network_tenant01_app
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant01_db" {
  name          = var.deploy_vsphere_network_tenant01_db
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant02_web" {
  name          = var.deploy_vsphere_network_tenant02_web
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant02_app" {
  name          = var.deploy_vsphere_network_tenant02_app
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant02_db" {
  name          = var.deploy_vsphere_network_tenant02_db
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_virtual_machine" "source_template" {
  name          = var.guest_template
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant03_web" {
  name          = var.deploy_vsphere_network_tenant03_web
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "target_network_tenant04_web" {
  name          = var.deploy_vsphere_network_tenant04_web
  datacenter_id = data.vsphere_datacenter.target_dc.id
}


##### Resources
# Clones a single Linux VM from a template
# TENANT 01


resource "vsphere_virtual_machine" "Tenant01_Web_01" {
  name             = "TENANT01-WEB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant01 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant01_web.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant01_web01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant01_web01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant01_web01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant01_web
      ipv6_gateway    = var.guest_ipv6_gateway_tenant01_web
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}






resource "vsphere_virtual_machine" "Tenant01_App_01" {
  name             = "TENANT01-APP-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant01 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant01_app.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant01_app01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant01_app01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant01_app01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant01_app
      ipv6_gateway    = var.guest_ipv6_gateway_tenant01_app
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}








resource "vsphere_virtual_machine" "Tenant01_Db_01" {
  name             = "TENANT01-DB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant01 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant01_db.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant01_db01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant01_db01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant01_db01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant01_db
      ipv6_gateway    = var.guest_ipv6_gateway_tenant01_db
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}






















##### Resources
# Clones a single Linux VM from a template
# TENANT 02


resource "vsphere_virtual_machine" "Tenant02_Web_01" {
  name             = "TENANT02-WEB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant02 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant02_web.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant02_web01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant02_web01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant02_web01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant02_web
      ipv6_gateway    = var.guest_ipv6_gateway_tenant02_web
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}






resource "vsphere_virtual_machine" "Tenant02_App_01" {
  name             = "TENANT02-APP-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant02 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant02_app.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant02_app01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant02_app01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant02_app01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant02_app
      ipv6_gateway    = var.guest_ipv6_gateway_tenant02_app
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}








resource "vsphere_virtual_machine" "Tenant02_Db_01" {
  name             = "TENANT02-DB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant02 

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant02_db.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant02_db01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant02_db01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant02_db01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant02_db
      ipv6_gateway    = var.guest_ipv6_gateway_tenant02_db
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}





resource "vsphere_virtual_machine" "Tenant03_Web_01" {
  name             = "TENANT03-WEB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant03

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant03_web.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant03_web01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant03_web01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant03_web01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant03_web
      ipv6_gateway    = var.guest_ipv6_gateway_tenant03_web
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}






resource "vsphere_virtual_machine" "Tenant04_Web_01" {
  name             = "TENANT04-WEB-01"
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.deploy_vsphere_folder_tenant04

  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  guest_id = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.target_network_tenant04_web.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.source_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.source_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = var.guest_hostname_tenant04_web01
        domain    = var.guest_domain
      }

      network_interface {
        ipv4_address = var.guest_ipv4_tenant04_web01
        ipv4_netmask = var.guest_ipv4_netmask
        ipv6_address = var.guest_ipv6_tenant04_web01
        ipv6_netmask = var.guest_ipv6_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway_tenant04_web
      ipv6_gateway    = var.guest_ipv6_gateway_tenant04_web
      dns_server_list = [var.guest_dns_servers]
      dns_suffix_list = [var.guest_dns_suffix]
    }
  }
}

