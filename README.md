# 🚀 Proxmox Terraform Setup

This repository helps you quickly set up and manage **Proxmox Virtual Environments** using **Terraform**.  
To get started, you’ll need to add and configure your `terraform.tfvars` file with your own credentials and settings.

---

## 📌 terraform.tfvars Example

Create a `terraform.tfvars` file in the root of your project and add the following values:

```hcl
# Proxmox API endpoint, including port and /api2/json suffix
proxmox_api_url = "https://yourproxmox:8006/api2/json"

# API token ID in the format: user@auth!token_name
# Example: root@pam!mytoken
proxmox_api_token_id = "root@pam!token"

# API token secret generated from Proxmox
proxmox_api_token = "yourAPItoken"

# Your SSH public key (used for VM access)
ssh_public_key = "your-ssh-public-key"

```
## Second must have is ubuntu cloudinit image on proxmox node
🐧 Installing Ubuntu 24.04 Noble Numbat Cloud-Init Image on Proxmox
Terraform will use a Cloud-Init ready image as the base for provisioning VMs.
Follow these steps on your Proxmox node:
## Download the Ubuntu Noble Cloud-Init Image:
```
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
```
## Create a new VM with ID 1000 (adjust storage and bridge as needed):
```
qm create 1000 --name "ubuntu-cloudinit" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
```
## Import the image into Proxmox storage (replace local-lvm with your storage name):
```
qm importdisk 1000 noble-server-cloudimg-amd64.img local-lvm
qm set 1000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-1000-disk-0
```
## Enable Cloud-Init:
```
qm set 1000 --ide2 local-lvm:cloudinit
qm set 1000 --boot c --bootdisk scsi0
qm set 1000 --serial0 socket --vga serial0
```
## Convert it into a template:
```
qm template 1000
```
s