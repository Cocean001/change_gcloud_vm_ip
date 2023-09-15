# 谷歌云虚拟机 IP 地址更换脚本

[EN](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/README.md) | ZH

### 0.0 说明

本脚本支持在不影响原有虚拟机数据的前提下，更换谷歌云上的虚拟机（VM）的外网 IP 地址。

PS：更换 ip 的时候会有短暂的服务中断。

### 1.0 前提条件

##### 1.1 安装好谷歌云 SDK

需要安装好 gcloud 命令行工具。

测试：

```shell
gcloud -v
```

![1.1-GCloud](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/screenshots/1.1-gcloud.png?raw=true)

##### 1.2 登录谷歌云账户

确保已经通过 gcloud 登录谷歌云账户（当然也需要先有一个谷歌云账户）。

##### 1.3 创建一个虚拟机和网络规则

可以手动创建一个 VM 虚拟机。也可以用 gcloud 在命令行里创建。
这里通过命令行创建示例配置为：

- 虚拟机名：my-vm-name
- 虚拟机系统：debian-10
- 虚拟机类型：n1-standard-1
- 防火墙规则：允许所有入站流量

```shell
# 创建虚拟机
gcloud compute instances create my-vm-name --image-family debian-10 --image-project debian-cloud --machine-type n1-standard-1

# 设置防火墙规则
gcloud compute firewall-rules create my-vm-name-allow-all --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all --source-ranges=0.0.0.0/0 --target-tags=my-vm-name
```

### 2.0 使用方法

##### 2.1 下载脚本到本地

```shell
curl -O https://raw.githubusercontent.com/Cocean001/change_gcloud_vm_ip/main/change_ip.sh && chmod +x change_ip.sh
```

或：

```shell
wget https://raw.githubusercontent.com/Cocean001/change_gcloud_vm_ip/main/change_ip.sh && chmod +x change_ip.sh
```

##### 2.2 打开脚本，修改几个设置

![2.2-GCloud](https://github.com/Cocean001/change_gcloud_vm_ip/blob/main/screenshots/2.2-configure.png?raw=true)
说明：

- VM_NAME：要修改 ip 的虚拟机名。
- STATIC_IP_NAME：新 IP 的临时名字，可以是任意值。
- REGION：想要把虚拟机分配到哪个区域。可以参照[可选区域列表](https://cloud.google.com/compute/docs/regions-zones?hl=zh-cn)

##### 2.3 运行脚本

```shell
bash change_ip.sh
```

### License

MIT

### 其他

- 本脚本只是为了学习和交流。在正式环境用，请自负风险。
