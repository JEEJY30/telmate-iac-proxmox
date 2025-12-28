resource "proxmox_vm_qemu" "cloud-init" {
  for_each = var.vm_configs

  vmid         = each.value.vm_id
  name         = each.value.name
  target_node  = "pve"

  clone        = "ubuntu-cloudinit"
  full_clone   = false
  bios         = "ovmf"
  agent        = 1
  scsihw       = "virtio-scsi-single"
  os_type      = "cloud-init"
  memory       = each.value.memory

  vm_state     = each.value.vm_state
  onboot       = each.value.onboot
  startup      = each.value.startup
  nameserver   = "192.168.0.135"
  tags         = each.value.tags
  ipconfig0    = each.value.ipconfig
  skip_ipv6    = true
  ciuser       = each.value.ciuser
  cipassword   = each.value.cipassword
  sshkeys      = var.ssh_public_key

  cpu {
    type    = "host"
    sockets = 1
    cores   = each.value.cores
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = each.value.bridge
    firewall = true
    tag      = each.value.network_tag
  }

  # 🧩 Dynamically attach all disks
  dynamic "disk" {
    for_each = each.value.disks
    content {
      slot       = "scsi${disk.key + 2}"
      type       = "disk"
      size       = disk.value.size
      storage    = disk.value.storage
      replicate  = lookup(disk.value, "replicate", true)
    }
  }

  # 🧩 Cloud-init drive (always ide2)
  disk {
    slot    = "scsi1"
    type    = "cloudinit"
    storage = "local-lvm"
  }

  lifecycle {
    # Prevent constant "update in place" loops caused by Proxmox
    ignore_changes = [
      disk,
    ]
  }
}
