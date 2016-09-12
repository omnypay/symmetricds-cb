#
# Cookbook Name:: symmetricds
# Attribute:: default
#
# Copyright (c) 2016 OmnyPay Inc., All Rights Reserved.

default['symmetricds']['base_dir'] = "/opt/symmetric-ds"
default['symmetricds']['distro']['base_url'] = "https://support.jumpmind.com/downloads/symmetricds/releases/"
default['symmetricds']['distro']['major'] = "3"
default['symmetricds']['distro']['minor'] = "8"
default['symmetricds']['distro']['patch'] = "3"
default['symmetricds']['config']['run_server_after_install'] = true
default['symmetricds']['config']['install_service'] = true
default['symmetricds']['config']['init']['dir'] = "/etc/init.d"
default['symmetricds']['config']['init']['service_name'] ="SymmetricDS"
default['symmetricds']['config']['jmx']['enabled'] = true
default['symmetricds']['config']['jmx']['port'] = 31416
default['symmetricds']['config']['jmx']['agent_enabled'] = true
default['symmetricds']['config']['jmx']['agent_port'] = 31418
default['symmetricds']['config']['http']['enabled'] = false
default['symmetricds']['config']['http']['port'] = 31415
default['symmetricds']['config']['https']['enabled'] = true
default['symmetricds']['config']['https']['port'] = 31417
default['symmetricds']['config']['memory']['size'] = 1024
default['symmetricds']['config']['memory']['select'] = 1024
