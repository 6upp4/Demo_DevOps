module "example" {
  source               = "./vm"
  vsphere_server       = "vcenter.example.local"
  num_cpus             = "10"
  datacenter           = "example.local"
  datastore            = "Store_SAS"
  vsphere_host         = "10.10.2.11"
  disk_size            = "16"
  memory               = "32768"
  network              = "VM Network"
  resource_pool        = "/Resources"
  vm_name              = "example_VM_DevOps"
  folder               = "ITOps"
  template_name        = "Debian10"
  template_os_family   = "linux"
  ipv4_network_address = "172.162.20.143"
  ipv4_gateway         = "172.162.20.1"
  domain_name          = "linux.example.local"
  dns_servers          = "172.162.20.100"
}
