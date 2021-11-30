##### Provider
# - Arguments to configure the VMware vSphere Provider

variable "provider_vsphere_host" {
  description = "vCenter server FQDN or IP - Example: vcsa01-z67.sddc.lab"
}

variable "provider_vsphere_user" {
  description = "vSphere username to use to connect to the environment - Default: administrator@vsphere.local"
  default     = "administrator@vsphere.local"
}

variable "provider_vsphere_password" {
  description = "vSphere password"
}

##### Infrastructure
# - Defines the vCenter / vSphere environment

variable "deploy_vsphere_datacenter" {
  description = "vSphere datacenter in which the virtual machine will be deployed."
}

variable "deploy_vsphere_cluster" {
  description = "vSphere cluster in which the virtual machine will be deployed."
}

variable "deploy_vsphere_datastore" {
  description = "Datastore in which the virtual machine will be deployed."
}

variable "deploy_vsphere_folder_tenant01" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
}

variable "deploy_vsphere_folder_tenant02" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
}

variable "deploy_vsphere_folder_tenant03" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
}

variable "deploy_vsphere_folder_tenant04" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
}



variable "deploy_vsphere_network_tenant01_web" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant01_app" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant01_db" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant02_web" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant02_app" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant02_db" {
  description = "Portgroup to which the virtual machine will be connected."
}


variable "deploy_vsphere_network_tenant03_web" {
  description = "Portgroup to which the virtual machine will be connected."
}

variable "deploy_vsphere_network_tenant04_web" {
  description = "Portgroup to which the virtual machine will be connected."
}


##### Guest
# - Describes virtual machine / guest options

variable "guest_template" {
  description = "The source virtual machine or template to clone from."
}

variable "guest_vcpu" {
  description = "The number of virtual processors to assign to this virtual machine. Default: 1."
  default     = "1"
}

variable "guest_memory" {
  description = "The size of the virtual machine's memory, in MB. Default: 1024 (1 GB)."
  default     = "1024"
}

variable "guest_hostname_tenant01_web01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant01_app01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant01_db01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant02_web01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant02_app01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant02_db01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant03_web01" {
  description = "Hostname for the virtual machine"
}

variable "guest_hostname_tenant04_web01" {
  description = "Hostname for the virtual machine"
}


variable "guest_ipv4_tenant01_web01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant01_web01" {
  description = "The IPv6 Address allocated for that virtual machine"
}

variable "guest_ipv4_tenant01_app01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant01_app01" {
  description = "The IPv6 Address allocated for that virtual machine"
}

variable "guest_ipv4_tenant01_db01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant01_db01" {
  description = "The IPv6 Address allocated for that virtual machine"
}


variable "guest_ipv4_tenant02_web01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant02_web01" {
  description = "The IPv6 Address allocated for that virtual machine"
}

variable "guest_ipv4_tenant02_app01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant02_app01" {
  description = "The IPv6 Address allocated for that virtual machine"
}

variable "guest_ipv4_tenant02_db01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant02_db01" {
  description = "The IPv6 Address allocated for that virtual machine"
}



variable "guest_ipv4_tenant03_web01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant03_web01" {
  description = "The IPv6 Address allocated for that virtual machine"
}


variable "guest_ipv4_tenant04_web01" {
  description = "The IPv4 Address allocated for that virtual machine"
}

variable "guest_ipv6_tenant04_web01" {
  description = "The IPv6 Address allocated for that virtual machine"
}


variable "guest_ipv4_netmask" {
  description = "The IPv4 subnet mask, in bits (example: 24 for 255.255.255.0)."
}

variable "guest_ipv6_netmask" {
  description = "The IPv6 subnet mask, in bits"
}

variable "guest_ipv4_gateway_tenant01_web" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant01_web" {
  description = "The IPv6 default gateway."
}


variable "guest_ipv4_gateway_tenant01_app" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant01_app" {
  description = "The IPv6 default gateway."
}

variable "guest_ipv4_gateway_tenant01_db" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant01_db" {
  description = "The IPv6 default gateway."
}

variable "guest_ipv4_gateway_tenant02_web" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant02_web" {
  description = "The IPv6 default gateway."
}

variable "guest_ipv4_gateway_tenant02_app" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant02_app" {
  description = "The IPv6 default gateway."
}

variable "guest_ipv4_gateway_tenant02_db" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant02_db" {
  description = "The IPv6 default gateway."
}


variable "guest_ipv4_gateway_tenant03_web" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant03_web" {
  description = "The IPv6 default gateway."
}

variable "guest_ipv4_gateway_tenant04_web" {
  description = "The IPv4 default gateway."
}

variable "guest_ipv6_gateway_tenant04_web" {
  description = "The IPv6 default gateway."
}




variable "guest_dns_servers" {
  description = "The list of DNS servers to configure on the virtual machine."
}

variable "guest_dns_suffix" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
}

variable "guest_domain" {
  description = "The domain name for this machine."
}