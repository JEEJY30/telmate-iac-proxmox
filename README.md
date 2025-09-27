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
