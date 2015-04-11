ssh_key_wrapper Cookbook
========================

[![Build Status](https://travis-ci.org/vkhatri/chef-ssh-key-wrapper.svg?branch=master)](https://travis-ci.org/vkhatri/chef-ssh-key-wrapper)

This is a [Chef] cookbook for Managing SSH Private Key file using Chef Data Bag and SSH Wrapper file mainly for GIT.

All SSH Private Keys are stored in a Databag as a Databag item to maintain simplicity.

SSH Private Key is stored in a Databag item which could be password protected.


## TODO

* add LWRP resource `public` to manage `authorized_keys`


## Cookbook Recipes

- `ddnsupdate::private_keys`   - manage ssh key and wrapper via node attribute using LWRP `ssh_key_wrapper_private`


## Repository

https://github.com/vkhatri/chef-ssh-key-wrapper


## Cookbook Dependencies

None


## Cookbook LWRP

**LWRP - ssh_key_wrapper_private**

ssh_key_wrapper_private LWRP is used to create/delete ssh private key file and ssh wrapper file.

**LWRP example**

*via node attribute:*

    "default_attributes": {
      "ssh_key_wrapper": {
      	"private_keys": {
          "test": {
            "user": "foo",
            "group": "foo",
            "key_name": "ssh-databag-item-name",
            "enable_wrapper": true,
            "wrapper_file": "wrapper file",
            "key_file" "ssh private key file",
            "databag": "data bag"
          }
        }
      }
    }



*Create a RR using LWRP*

    ssh_key_wrapper_private "foo" do
      option option_name
    end

*Delete a RR using LWRP*

    ssh_key_wrapper_private "key name" do
      option option_name
      action :delete
    end


**LWRP Options**

Parameters:

- *key_name* - ssh private key file name, LWRP will lookup a data bag item with this attribute value
- *databag (default: `node['ssh_key_wrapper']['databag']`)* - data bag to read ssh private key file item
- *databag_secret (default: `node['ssh_key_wrapper']['databag_secret']`)* - encrypted data bag secret
- *cookbook (default: `node['ssh_key_wrapper']['wrapper']`)* - ssh wrapper file template cookbook
- *template (default: `node['ssh_key_wrapper']['template']`)* - ssh wrapper file template name
- *enable_wrapper (default: `node['ssh_key_wrapper']['enable_wrapper']`)* - whether to create ssh wrapper
- *wrapper_file (default: `$HOME/.ssh/#{key_name}_wrapper`)* - ssh wrapper file path
- *key_file (default: `$HOME/.ssh/#{key_name}`)* - ssh private key file path
- *key_secret (default: `nil`)* - if provided, decrypt ssh private key
- *user (default: `node['ssh_key_wrapper']['user']`)* - owner of ssh private key file
- *group (deault: `node['ssh_key_wrapper']['group']`)* - group of ssh private key file

- *manage_key_dir (deault: `node['ssh_key_wrapper']['manage_key_dir']`)* - manage ssh private key file directory


## Cookbook Core Attributes

 * `default[:ssh_key_wrapper][:databag]` (default: `ssh_key_wrapper`): data bag for ssh key content, each ssh key is a data bag item.

    Note: ssh private key data bag item must have an attribute 'key' with ssh private key content

 * `default['ssh_key_wrapper']['databag_secret']` (default: `ssh_key_wrapper`): encrypted data bag secret
 * `default['ssh_key_wrapper']['cookbook']` (default: `ssh_key_wrapper`): cookbook for ssh wrapper file template
 * `default['ssh_key_wrapper']['template']` (default: `wrapper.erb`): template name for ssh wrapper file
 * `default['ssh_key_wrapper']['enable_wrapper']` (default: `true`): create ssh wrapper
 * `default['ssh_key_wrapper']['user']` (default: `root`): default ssh key and wrapper file owner
 * `default['ssh_key_wrapper']['group']` (default: `root`): default ssh key and wrapper file group
 * `default['ssh_key_wrapper']['private_keys']` (default: `{}`): attribute used by recipe `ssh_key_wrapper::private_keys` to create `ssh_key_wrapper_private` resources
 * `default['ssh_key_wrapper']['manage_key_dir']` (default: `true`): manage ssh private key file directory


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>

[Chef]: https://www.getchef.com/chef/
[Contributors]: https://github.com/vkhatri/chef-ssh-key-wrapper/graphs/contributors
