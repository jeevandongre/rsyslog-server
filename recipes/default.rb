#
# Cookbook Name:: rsyslog-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

##Node Discovery
node.set[:announce][:rsyslogserver] = true
node.save

execute 'rsyslogrepo'  do
  command "sudo add-apt-repository ppa:adiscon/v8-stable"
end

execute "update" do
  command "sudo apt-get update"
end

apt_package 'rsyslog' do
  action :install          
end	

template "/etc/rsyslog.conf" do
	source "rsyslog.conf.erb"
	owner "syslog"
	group "adm"
	mode "0640"
end	

service "rsyslog" do
	action :restart
end	