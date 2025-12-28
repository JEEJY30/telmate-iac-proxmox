variable proxmox_api_url {
  type = string
}

variable proxmox_api_token_id {
  type = string
}

variable proxmox_api_token {
  type = string
}

variable ssh_public_key {
  type = string
}

variable vm_configs {
  type = map(object({
      vm_id       = number
      name        = string
      memory      = number
      vm_state    = string
      onboot      = bool
      startup     = string
      ipconfig    = string
      ciuser      = string
      cipassword  = string
      cores       = number
      bridge      = string
      network_tag = number
      tags        = string
      disks       = list(object({
        size       = string
        storage    = string
        replicate  = optional(bool)
      }))
    }))
    default = {
      "master" = {
        vm_id       = 1001
        name        = "master"
        memory      = 4112
        vm_state    = "running"
        onboot      = true
        startup     = "order=2"
        ipconfig    = "ip=192.168.0.10/24,gw=192.168.0.1"
        ciuser      = "helper"
        cipassword  = "helper"
        cores       = 3
        bridge      = "vmbr0"
        network_tag = 0
        tags        = "master"
        disks       = [
          { size = "200G", storage = "ZFS" }
        ]
      }
      "worker-1" = {
        vm_id       = 1002
        name        = "worker-1"
        memory      = 8192
        vm_state    = "running"
        onboot      = true
        startup     = "order=2"
        ipconfig    = "ip=192.168.0.11/24,gw=192.168.0.1"
        ciuser      = "helper"
        cipassword  = "helper"
        cores       = 6
        bridge      = "vmbr0"
        network_tag = 0
        tags        = "worker-1"
        disks       = [
          { size = "200G", storage = "ZFS" }
        ]
      }
      "worker-2" = {
        vm_id       = 1003
        name        = "worker-2"
        memory      = 4112
        vm_state    = "running"
        onboot      = true
        startup     = "order=2"
        ipconfig    = "ip=192.168.0.12/24,gw=192.168.0.1"
        ciuser      = "helper"
        cipassword  = "helper"
        cores       = 3
        bridge      = "vmbr0"
        network_tag = 0
        tags        = "worker-2"
        disks       = [
          { size = "200G", storage = "ZFS" },
          { size = "50G",  storage = "ZFS" },
          { size = "50G",  storage = "ZFS" },
          { size = "50G",  storage = "ZFS" },
          { size = "50G",  storage = "ZFS" }
        ]
      }
      "Argo-CD" = {
        vm_id       = 1004
        name        = "rancher"
        memory      = 4112
        vm_state    = "running"
        onboot      = true
        startup     = "order=2"
        ipconfig    = "ip=192.168.0.100/24,gw=192.168.0.1"
        ciuser      = "helper"
        cipassword  = "helper"
        cores       = 3
        bridge      = "vmbr0"
        network_tag = 0
        tags        = "Argo-CD"
        disks       = [
          { size = "54G", storage = "ZFS" },
        ]
      }

    }
}
