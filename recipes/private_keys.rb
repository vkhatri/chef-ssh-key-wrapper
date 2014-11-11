#
# Cookbook Name:: ssh_key_wrapper
# Recipe:: keys
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

node['ssh_key_wrapper']['private_keys'].each do |key, options|
  ssh_key_wrapper_private key do
    enable_wrapper options['enable_wrapper']
    wrapper_file options['wrapper_file']
    key_file options['key_file']
    key_secret options['key_secret']
    key_name options['key_name']
    databag options['databag']
    cookbook options['cookbook']
    template options['template']
    user options['user']
    group options['group']
    action options['action']
  end
end
