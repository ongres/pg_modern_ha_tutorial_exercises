Ansible role Etcd
==========

# Table of Contents
- [Description](#description)
- [Requirements](#requirements)
- [Role variables](#role variables)

This role can be used to do the following tasks on RHEL based systems:
- Install etcd and etcdctl binary
- Setup an Etcd Cluster

By default the role does nothing because __etcd_install__ and __etcd_service__ are set to false.

# Requirements

- Ansible >= 1.9

# Role variables

## Install variables
| Name | Description | Default value |
|:-----  | :----- | :----- |
| etcd_version | Version to install | v2.0.10 |
| etcd_package_name | Name of Etcd package | etcd-{{ etcd_version }}-linux-amd64 |
| etcd_package_file | Filename of tar.gz containing pre-compiled binaries | {{ etcd_package_name }}.tar.gz |
| etcd_url | URL the package will be downloaded from | https://github.com/coreos/etcd/releases/download/ |
| etcd_download_path | Path where to download tar.gz package | /tmp |
| etcd_install | Boolean to define if the installation should be done | false |
| etcd_install_path | String to define where binaries will be installed | /usr/local/bin |
| etcd_install_owner | String to define the binary and data dir owner | root |
| etcd_install_group | String to define the binary and data dir group | root |
| etcd_install_mode | String to define the binary file mode | '0755' |

## Service variables

| Name | Description | Default value |
|:-----  | :----- | :----- |
| etcd_service | Boolean to define if a service (sysvinit or systemd depending on ansible_distribution_major_version) should be installed | false |
| etcd_service_state | Service state | running |
| etcd_service_enabled | Boolean to define if service should start on boot | true |
| etcd_service_file_template | Filename of Jinja2 template to be used to generate the service file | (RHEL < 7) = etcd.init.j2, (RHEL >= 7) = etcd.service.j2

## Etcd Cluster variables

| Name | Description | Default value |
|:-----  | :----- | :----- |
| etcd_cluster_name | String to define the Etcd Cluster name | default |
| etcd_cluster_data_dir  | String to define the directory where Etcd can store data | /var/lib/etcd |
| etcd_cluster_group_name | Name of Ansible host group which contains the Cluster members | null |

# Examples

## Download and install binaries
Download and install binaries into /usr/local/bin/{etcd,etcdctl}

```yaml
- hosts: 127.0.0.1
  become: true
  become_user: root
  become_method: sudo
  roles:
  - role: etcd
    etcd_install: true
```

## Setup an Etcd Cluster
Download and install Etcd binaries on all members of group etcd-cluster. Setup an Etcd cluster
named _test_ storing data in /var/lib/etcd.

__Important__:
Ensure to set __etcd_cluster_group_name__ to the group name used in your inventory file as the
Jinja2 templates are using group variables to get the ip of each cluster member.

```yaml
- hosts: etcd-cluster
  gather_facts: false
  roles:
  - role: etcd
    etcd_install: true
    etcd_service: true
    etcd_cluster_name: test
    etcd_cluster_data_dir: /var/lib/etcd
    etcd_cluster_group_name: etcd-cluster
```

# License

Copyright 2015 Thomas Krahn

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Author Information

[Thomas Krahn]

[Thomas Krahn]: mailto:ntbc@gmx.net
