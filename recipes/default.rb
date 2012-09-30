# Author:: Juan M. Uys (<opyate@gmail.com>)
# Cookbook Name:: typesafe_stack
# Recipe:: typesafe_stack
#
# Copyright 2010-2011, Opscode, Inc.
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

typesafe_stack_home = node['typesafe_stack']['typesafe_stack_home']
typesafe_stack_home_parent = ::File.dirname typesafe_stack_home

pkgs = value_for_platform(
  ["ubuntu","debian","amazon"] => {
    "default" => ["typesafe-stack"]
  },
  "default" => ["typesafe-stack"]
  )

ruby_block  "set-env-typesafe_stack-home" do
  block do
    ENV["TYPESAFE_STACK_HOME"] = typesafe_stack_home
  end
end

# set persistent environment variable
#file "/etc/profile.d/typesafe-stack.sh" do
#  mode 0500
#  content <<-EOH
#export TYPESAFE_STACK_HOME=
#  EOH
#end

# http://apt.typesafe.com/repo-deb-build-0002.deb

# 1. Download the .deb file
remote_file "/tmp/typesafe-stack.deb" do
	source "http://apt.typesafe.com/repo-deb-build-0002.deb"
	mode 0644
	checksum "dc048f96319121d22317c37b307778a3657e10ce6c3a58e0190a50052fa320e8"
end

# 2. Install the .deb file
dpkg_package "typesafe-stack" do
	source "/tmp/typesafe-stack.deb"
	action :install
	notifies :run, resources("execute[apt-get update]"), :immediately
end

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
