#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

jenkins_home ||= "/var/lib/jenkins"
plugin_path = "#{jenkins_home}/plugins"
plugin_repo = "http://updates.jenkins-ci.org/latest/"
plugins = ['gradle','git','greenballs']

bash "setup_jenkins_repo" do
  if ::File.exists?("/etc/yum.repos.d/jenkins.repo")
    action :nothing
  else
    code <<-EOH
      wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
      rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
    EOH
    action :run
  end
end

yum_package "jenkins" do
  if `rpm -qa | grep jenkins`.empty?
    action :install
  else
    action :nothing
  end
end

#bash "download_jenkins_plugin_gradle" do
#  code <<-EOH
#    wget -O /var/lib/jenkins/plugins/gradle.hpi http://updates.jenkins-ci.org/latest/gradle.hpi --no-check-certificate
#  EOH
#  action :run
#end

plugins.each do |plugin|
  local="#{plugin_path}/#{plugin}.hpi"
  remote="#{plugin_repo}/#{plugin}.hpi"

  remote_file local do
    source remote
    mode "0644"
    not_if { ::File.exists?(local) }
  end
end
