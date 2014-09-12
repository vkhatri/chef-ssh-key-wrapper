ssh_key_wrapper Cookbook
========================

This is an [OpsCode Chef] cookbook for Managing SSH Private Key using Chef Data Bag and SSH Wrapper mainly for GIT.

All SSH Private Keys are stored in a Databag as a Databag item.


## Cookbook Recipes

- `ddnsupdate::keys`   - manage ssh key and wrapper via node attribute using LWRP


## Cookbook Repository

https://github.com/vkhatri/chef-ssh-key-wrapper


## Cookbook Dependencies

None


## Cookbook LWRP

**LWRP - ssh_key_wrapper_private*

ssh_key_wrapper_private LWRP is used to create/delete ssh private key file and ssh wrapper file.

**LWRP example**

*via node attribute:*

    "default_attributes": {
			"ssh_key_wrapper": {
      	"private_keys": {
        	"test": {
          	"user": "virender",
          	"group": "devops"
        	}
      	}
			}
		}



*Create a RR using LWRP*

    ssh_key_wrapper_private "key name" do
      option option_name
    end

*Delete a RR using LWRP*

    ssh_key_wrapper_private "key name" do
      option option_name
      action :delete
    end


**LWRP Options**


Parameters:

- *key_name* - ssh private key file name, set to name_attribute

- *databag (default: `node.ssh_key_wrapper.databag`)* - data bag to read ssh private key file item
- *cookbook (default: `node.ssh_key_wrapper.wrapper`)* - ssh wrapper file template cookbook
- *template (default: `node.ssh_key_wrapper.template`)* - ssh wrapper file template name

- *enable_wrapper (default: `node.ssh_key_wrapper.enable_wrapper`)* - enable/disable create ssh wrapper for a private key
- *wrapper_file* - ssh wrapper file path, default to user $HOME/.ssh/#{key_name}_wrapper
- *key_file* - ssh private key file path, default to user $HOME/.ssh/#{key_name}
- *key_secret* - if provided, decrypt ssh private key before create ssh key file

- *user (default: `node.ssh_key_wrapper.user`)* - owner of ssh private key file
- *group (deault: `node.ssh_key_wrapper.group`)* - group of ssh private key file


## Cookbook Core Attributes

 * `default[:ssh_key_wrapper][:databag]` (default: `ssh_key_wrapper`): data bag for ssh key content, each ssh key is a data bag item.

    Note: ssh private key data bag item attribute is 'key'

 * `default[:ssh_key_wrapper][:cookbook]` (default: `ssh_key_wrapper`): cookbook for ssh wrapper file template
 * `default[:ssh_key_wrapper][:template]` (default: `wrapper.erb`): template name for ssh wrapper file
 * `default[:ssh_key_wrapper][:enable_wrapper]` (default: `true`): create ssh wrapper
 * `default[:ssh_key_wrapper][:user]` (default: `root`): default ssh key and wrapper file owner
 * `default[:ssh_key_wrapper][:group]` (default: `root`): default ssh key and wrapper file group
 * `default[:ssh_key_wrapper][:private_ssh_keys]` (default: `{}`): attribute used by recipe `ssh_key_wrapper::private_keys` to create `ssh_key_wrapper_private` resources


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Write description about changes
7. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri (vir.khatri@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[Opscode Chef]: https://wiki.opscode.com/display/chef/Home
