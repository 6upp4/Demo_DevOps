resource "vsphere_virtual_machine" "virtual_machine_linux" {
  count            = var.template_os_family == "linux" ? var.vm_count : 0
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id
  folder           = var.folder

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id
  boot_delay = 5000

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = var.disk_size != "" ? var.disk_size : data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = var.linked_clone == "true" ? data.vsphere_virtual_machine.template.disks.0.thin_provisioned : false
    eagerly_scrub    = var.linked_clone == "true" ? data.vsphere_virtual_machine.template.disks.0.eagerly_scrub: true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = var.domain_name
        time_zone = var.time_zone != "" ? var.time_zone : "UTC"
      }

      network_interface {
        ipv4_address = var.ipv4_network_address
        ipv4_netmask = var.ipv4_netmask
        }

      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = [var.dns_servers]
      dns_suffix_list = [var.domain_name]
    }
  }
}


resource "vsphere_virtual_machine" "virtual_machine_windows" {
  count            = var.template_os_family == "windows" ? var.vm_count : 0
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id
  folder           = var.folder 

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = var.disk_size != "" ? var.disk_size : data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = var.linked_clone == "true" ? data.vsphere_virtual_machine.template.disks.0.thin_provisioned : false
    eagerly_scrub    = var.linked_clone == "true" ? data.vsphere_virtual_machine.template.disks.0.eagerly_scrub: true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone

    customize {
      windows_options {
        computer_name  = var.vm_name
        admin_password = var.admin_password
        join_domain    = var.domain_name
        time_zone      = var.time_zone != "" ? var.time_zone : "85"
      }

      network_interface {
        ipv4_address    = var.ipv4_network_address
        ipv4_netmask    = var.ipv4_netmask
        dns_server_list = [var.dns_servers]
        dns_domain      = var.domain_name
      }
      ipv4_gateway = var.ipv4_gateway
    }
  }
}

