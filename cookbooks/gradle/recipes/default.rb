#
# Cookbook Name:: gradle
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
GRADLE_VERSION = node.default["gradle"]["version"]
GRADLE_DIST_BASE_URL = 'http://services.gradle.org/distributions'
GRADLE_FILENAME = "gradle-#{GRADLE_VERSION}-bin.zip"
GRADLE_URL = "#{GRADLE_DIST_BASE_URL}/#{GRADLE_FILENAME}"
GRADLE_TMP_FILE = "/tmp/#{GRADLE_FILENAME}"
GRADLE_BASE = "/usr/local"
GRADLE_PATH = "#{GRADLE_BASE}/gradle-#{GRADLE_VERSION}"
GRADLE_BIN = "#{GRADLE_PATH}/bin/gradle"

if File.exists?(GRADLE_BIN)
  puts "gradle existed, nothing to do"
else
  remote_file GRADLE_TMP_FILE do 
    source GRADLE_URL 
    mode "0644" 
  end

  execute "install gradle" do
    command "unzip #{GRADLE_TMP_FILE} -d #{GRADLE_BASE}"
  end

  link "/usr/bin/gradle" do
    to GRADLE_BIN
  end
end
