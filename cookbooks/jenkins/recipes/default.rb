#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "setup_jenkins_repo" do
  code <<-EOH
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  EOH
  action :run
end

yum_package "jenkins" do
  action :install
end

bash "download_jenkins_plugin_gradle" do
  code <<-EOH
    wget -O /var/lib/jenkins/plugins/gradle.hpi http://updates.jenkins-ci.org/latest/gradle.hpi --no-check-certificate
  EOH
  action :run
end


directory "/tmp/chef/test" do
  owner "root"
  group "root"
  mode 00644
  recursive true
  action :create
end
