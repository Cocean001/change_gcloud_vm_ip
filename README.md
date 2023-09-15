# Google Cloud VM IP Address Change Scripts

EN | [ZH](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/README_ZH.md)

### 0.0 Description

This script supports changing the external IP address of a virtual machine (VM) on Google Cloud without affecting the data of the original VM.

PS: There will be a short service interruption when changing the ip.

### 1.0 Requirements

#### 1.1 Google Cloud SDK is installed.

The gcloud command line tool needs to be installed.

Test:

```shell
gcloud -v
```

![1.1-GCloud](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/screenshots/1.1-gcloud.png?raw=true)https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/screenshots/1.1-gcloud.png?raw=true

#### 1.2 Signing in to a Google Cloud Account

Make sure you are already logged into your Google Cloud account via gcloud (and of course you need to have a Google Cloud account first).

#### 1.3 Create a VM and network rules

A VM virtual machine can be created manually. It can also be created on the command line using gcloud.
Here is a sample configuration for creating it from the command line:

- VM name: my-vm-name
- VM system: debian-10
- VM type: n1-standard-1
- Firewall rules: Allow all inbound traffic

```shell
# Create the virtual machine
gcloud compute instances create my-vm-name --image-family debian-10 --image-project debian-cloud --machine-type n1-standard-1

# Set up firewall rules
gcloud compute firewall-rules create my-vm-name-allow-all --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all - - -source-ranges=0 - -source-ranges=0 - -source-ranges=0 - -source-ranges=0 - -source-ranges=0 -source-ranges=0.0.0.0/0 --target-tags=my-vm-name
```

### 2.0 Usage

#### 2.1 Downloading the script locally

```shell
curl -O https://raw.githubusercontent.com/Cocean001/change_gcloud_vm_ip/main/change_ip.sh && chmod +x change_ip.sh
```

Or:

```shell
wget https://raw.githubusercontent.com/Cocean001/change_gcloud_vm_ip/main/change_ip.sh && chmod +x change_ip.sh
```

#### 2.2 Open the script and change a few settings

![2.2-GCloud](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/screenshots/2.2-configure.png?raw=true)
Description:

- VM_NAME: the virtual machine name of the ip to be modified.
- STATIC_IP_NAME: temporary name of the new IP, can be any value.
- REGION: which region you want to assign the VM to. You can refer to [list of optional regions](https://cloud.google.com/compute/docs/regions-zones?hl=zh-cn)

#### 2.3 Run the script

```shell
bash change_ip.sh
```

### Licence

MIT

### Others

- This script is for learning and communication purposes only. Use it in a formal environment at your own risk.
