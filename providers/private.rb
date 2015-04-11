#
# Cookbook Name:: ssh_key_wrapper
# Provider:: private
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

def default_key_file(user, key_name)
  ::File.join(node['etc']['passwd'][user]['dir'], '.ssh', key_name)
end

action :create do
  if new_resource.databag_secret
    secret = Chef::EncryptedDataBagItem.load_secret(new_resource.databag_secret)
    databag = data_bag_item(new_resource.databag, new_resource.key_name, secret)
  else
    databag = data_bag_item(new_resource.databag, new_resource.key_name)
  end

  fail "data bag or data bag key item does not exists, databag #{new_resource.databag} must have an item #{new_resource.key_name}" unless databag

  # verify data bag item ssh private key content attribute - 'key'
  key_content = databag['key']
  fail "databag #{new_resource.databag} item #{new_resource.key_name} must have ssh key content attribute 'key'" unless key_content

  # decrypt ssh private key provided key_secret
  key_content = OpenSSL::PKey.read(key_content, new_resource.key_secret) if new_resource.key_secret

  # default to user $HOME/.ssh/#{new_resource.key_name}
  key_file = new_resource.key_file || default_key_file(new_resource.user, new_resource.key_name)
  wrapper_file = new_resource.wrapper_file || (key_file + '_wrapper')

  d = directory ::File.dirname(key_file) do
    owner new_resource.user
    group new_resource.group
    mode 0700
    only_if { new_resource.manage_key_dir }
  end

  f = file "ssh_private_key_file_#{key_file}" do
    path key_file
    content key_content
    owner new_resource.user
    group new_resource.group
    mode 0400
  end

  t = template "ssh_wrapper_file_#{wrapper_file}" do
    path wrapper_file
    cookbook new_resource.cookbook
    source new_resource.template
    owner new_resource.user
    group new_resource.group
    mode 0550
    variables(:key => key_file)
    only_if { new_resource.enable_wrapper }
  end

  new_resource.updated_by_last_action(true) if d.updated? || f.updated? || t.updated?
end

action :delete do
  key_file = new_resource.key_file || default_key_file(new_resource.user, new_resource.key_name)
  wrapper_file = new_resource.wrapper_file || (key_file + '_wrapper')

  f = file "ssh_private_key_file_#{key_file}" do
    action :delete
  end

  w = file "ssh_wrapper_file_#{wrapper_file}" do
    action :delete
    only_if { new_resource.enable_wrapper }
  end

  new_resource.updated_by_last_action(true) if f.updated? || w.updated?
end
