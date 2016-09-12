#
# Cookbook Name:: symmetricds
# Recipe:: default
#
# Copyright (c) 2016 OmnyPay Inc., All Rights Reserved.

ds = node['symmetricds']
distro = ds['distro']
ds_dir = ds['base_dir']

# Get from * https://support.jumpmind.com/downloads/symmetricds/releases/3.8/symmetric-pro-3.8.2-setup.jar
major = distro['major']
minor = distro['minor']
patch = distro['patch']
setup_jar = "symmetric-pro-#{major}.#{minor}.#{patch}-setup.jar"
ds_url = "#{distro['base_url']}/#{major}.#{minor}/#{setup_jar}"
setup_jar_path = File.join(Chef::Config[:file_cache_path], setup_jar)
remote_file setup_jar_path do
  source ds_url
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
end

directory ds_dir do
  recursive true
  owner 'root'
  group 'root'
end

config = ds['config']
service_already_installed = File.exists?(File.join(config['init']['dir'], config['init']['service_name']))
install_service = service_already_installed ? false : config['install_service']

template File.join(ds_dir, "auto-install.xml") do
  owner 'root'
  group 'root'
  mode '0644'
  source "auto-install.xml.erb"
  variables({
              ds_dir: ds_dir,
              run_server_after_install: config['run_server_after_install'],
              install_service: install_service
              jmx_enabled: config['jmx']['enabled'],
              jmx_port: config['jmx']['port'],
              jmx_agent_enabled: config['jmx']['agent_enabled'],
              jmx_agent_port: config['jmx']['agent_port'],
              http_enabled: config['http']['enabled'],
              http_port: config['http']['port'],
              https_enabled: config['https']['enabled'],
              https_port: config['https']['port'],
              memory_size: config['memory']['size'],
              memory_select: config['memory']['select']
           })
end

bash "install_symmetricds" do
  cwd ds_dir
  code "java -jar #{setup_jar} -console auto-install.xml"
  not_if {File.exists?(File.join(ds_dir, "Uninstaller"))}
end

=begin
central master db.url:
jdbc:postgresql://ariadne-db-000-a.priv.prod0.omnypay.net/ariadne-prod0?protocolVersion=3&stringtype=unspecified&socketTimeout=300&tcpKeepAlive=true

clien db.url:
jdbc:postgresql://ariadne-db-000-b.priv.prod1.omnypay.net/ariadne-prod1?protocolVersion=3&stringtype=unspecified&socketTimeout=300&tcpKeepAlive=true

 Autoregistration link
 https://symmetricds-000.prod0.omnypay.net:31417/sync/master-1
 Before Write Script
engine.getSqlTemplate.update("SET foreign_key_checks = 0");

 After Write Script
engine.getSqlTemplate.update("SET foreign_key_checks = 1");
=end
