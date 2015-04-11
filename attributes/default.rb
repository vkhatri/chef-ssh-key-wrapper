
default['ssh_key_wrapper']['databag']   = 'ssh_key_wrapper'
default['ssh_key_wrapper']['databag_secret']   = nil
# ssh wrapper file template cookbook
default['ssh_key_wrapper']['cookbook']  = 'ssh_key_wrapper'
# ssh wrapper file template
default['ssh_key_wrapper']['template']  = 'wrapper.erb'
default['ssh_key_wrapper']['user']      = 'root'
default['ssh_key_wrapper']['group']     = 'root'
default['ssh_key_wrapper']['private_keys']   = {}
default['ssh_key_wrapper']['enable_wrapper']  = true
default['ssh_key_wrapper']['manage_key_dir'] = true
