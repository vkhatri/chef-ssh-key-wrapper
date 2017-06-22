#
# Cookbook Name:: ssh_key_wrapper
# Resource:: private
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

actions :create, :delete

default_action :create

attribute :enable_wrapper,  :kind_of => [TrueClass, FalseClass], :default => node['ssh_key_wrapper']['enable_wrapper']
attribute :wrapper_file,    :kind_of => String, :default => nil
attribute :manage_key_dir,  :kind_of => [TrueClass, FalseClass], :default => node['ssh_key_wrapper']['manage_key_dir']
attribute :key_file,        :kind_of => String, :default => nil
attribute :key_secret,      :kind_of => String, :default => nil
attribute :key_name,        :kind_of => String, :name_attribute => true,  :default => nil
attribute :databag,         :kind_of => String, :default => node['ssh_key_wrapper']['databag']
attribute :databag_secret,  :kind_of => String, :default => node['ssh_key_wrapper']['databag_secret']
attribute :user,      :kind_of => String, :default => node['ssh_key_wrapper']['user']
attribute :group,     :kind_of => String, :default => node['ssh_key_wrapper']['group']
attribute :cookbook,  :kind_of => String, :default => node['ssh_key_wrapper']['cookbook']
attribute :template,  :kind_of => String, :default => node['ssh_key_wrapper']['template']
