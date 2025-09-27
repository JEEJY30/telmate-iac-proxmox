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
        size        = string
        tags        = string
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
        size        = "200G"
        tags        = "master"
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
        size        = "200G"
        tags        = "worker-1"
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
        size        = "200G"
        tags        = "worker-2"
      }
    }
}
