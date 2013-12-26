#
# Cookbook Name:: tengine
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

TENGINE_NAME = "tengine-#{node["tengine"]["version"]}"
TENGINE_TAR = "#{TENGINE_NAME}.tar.gz"
TENGINE_TAR_URL = "http://tengine.taobao.org/download/#{TENGINE_TAR}"

remote_file "/tmp/#{TENGINE_TAR}" do
  source TENGINE_TAR_URL
  mode "0644"
end
