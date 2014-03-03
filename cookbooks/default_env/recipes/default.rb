#
# Cookbook Name:: default_env
# Recipe:: default
#
# Copyright 2013, skywalker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

profile_configs = ["alias rm='rm -i'",
                   "alias vi='vim'",
                   "alias cp='cp -i'",
                   "alias mv='mv -i'",
                   "ulimit -n 81920"]

profile_configs.each do |conf|
  ruby_block "ensure profile has #{conf}" do
    block do
      fe = Chef::Util::FileEdit.new("/etc/profile")
      fe.insert_line_if_no_match(/#{conf}/,"#{conf}")
      fe.write_file
    end
  end
end


def install_package(name)
  yum_package name do
    if `rpm -qa | grep #{name}`.empty?
      action :install
    else
      action :nothing
    end
  end
end

install_package "wget"
install_package "yum"
install_package "unzip"
install_package "libstdc++"
install_package "glibc"
install_package "zlib"
install_package "lrzsz"
install_package "dstat"
install_package "dmidecode"
