#
# Cookbook Name:: nova
# Recipe:: volume
#
# Copyright 2010, Opscode, Inc.
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

include_recipe "nova::common"
nova_package("volume")

service "iscsitarget" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

file "/etc/default/iscsitarget" do
  content <<-EOH
ISCSITARGET_ENABLE=true
EOH
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "iscsitarget"), :immediately
end
