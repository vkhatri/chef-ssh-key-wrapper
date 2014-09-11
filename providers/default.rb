#
# Cookbook Name:: ssh_key_wrapper
# Provider:: default
#
# Copyright 2014, Virender Khatri
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


def whyrun_supported?
  true
end

action :create do

  puts Chef::VERSION
  databag = data_bag_item(new_resource.databag, new_resource.key_name)
  raise "data bag or data bag key item does not exists, databag #{new_resource.databag} must have an item #{new_resource.key_name}" unless databag

  key_content = databag['key']
  raise "databag #{new_resource.databag} item #{new_resource.key_name} must have ssh key content attribute 'key'" unless key_content

  file new_resource.key_file do
    content key_content
    owner   new_resource.user
    group   new_resource.group
    mode    0400
  end


  template new_resource.wrapper_file do
    cookbook  new_resource.cookbook
    source    new_resource.template
    owner     new_resource.user
    group     new_resource.group
    mode      0550
    variables ({:key => new_resource.key_file })
  end

end

action :delete do
  file new_resource.key_file do
    action :delete
  end

  file new_resource.wrapper_file do
    action :delete
  end
end
