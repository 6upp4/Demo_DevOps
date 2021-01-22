variable "vsphere_server" {
  default = ""
}
variable "datacenter" {
  type        = string
  description = "The datacenter to deploy the virtual machines to."
}

variable "resource_pool" {
  description = "The resource pool to deploy the virtual machines to. If specifying a the root resource pool of a cluster, enter CLUSTER_NAME/Resources."
}

variable "datastore" {
  type        = string
  description = "The datastore to deploy the virtual machines to."
}

variable "network" {
  type        = string
  description = "The network to deploy virtual machines to."
}

variable "vm_name" {
  type        = string
  description = "The prefix to use for virtual machines created with this module."
}

variable "vm_count" {
  description = "The number of virtual machines to create."
  default     = "1"
}

variable "template_os_family" {
  description = "The OS family of the supplied template. Should be one of linux or windows. Leave blank to create a virtual machine from scratch."
  default     = ""
}

variable "template_name" {
  description = "The template to clone virtual machines from. Leave this blank when creating a virtual machine from scratch."
  default     = ""
}

variable "num_cpus" {
  description = "The number of virtual CPUs to assign each virtual machine."
  default     = "2"
}

variable "memory" {
  description = "The amount of memory, in MB, to assign each virtual machine."
  default     = "1024"
}

variable "disk_size" {
  description = "The amount of disk space to assign to each VM. Leave blank to use the template's disk size (cloned VMs only)."
  default     = ""
}


variable "wait_for_guest_net_timeout" {
  description = "The timeout, in mintues, to wait for the guest network when creating virtual machines. On virtual machines created from scratch, you may wish to adjust this value to -1, which will disable the waiter."
  default     = "5"
}

variable "linked_clone" {
  description = "Clone the VM from a snapshot. If selected, the VM must have a single snapshot created. Cloned VMs only."
  default     = "false"
}

variable "domain_name" {
  description = "The domain of the virtual machine. This is added as the domain name on Linux, and to the DNS domain search list on both Linux and Windows."
  default     = ""
}

variable "ipv4_gateway" {
  description = "The default IPv4 gateway for the virtual machines. Leave blank for DHCP."
  default     = ""
}
variable "ipv4_network_address" {
  description = "The defaultnetwork mask for the virtual machines."
  default     = ""
}
variable "ipv4_netmask" {
  description = "The defaultnetwork mask for the virtual machines."
  default     = "24"
}
variable "dns_servers" {
  description = "The DNS servers to assign to each virtual machine."
  default     = []
}

variable "time_zone" {
  description = "The timezone, either in a timezone database format entry or sysprep entry, depending on if Linux or Windows is being deployed. The default is UTC on both family types."
  default     = ""
}

variable "admin_password" {
  description = "The administrator password for Windows machines. This is a sensitive field and will not be output on-screen, but is stored in state and sent to the VM in plain text - keep this in mind when provisioning your infrastructure."
  default     = ""
}

variable "folder" {
  description = "Folder for VM"
  default     = ""
}

variable "vsphere_host" {
  description = "ESXi hostname for VM"
  default     = ""
}
