
default[:ssh_key_wrapper] = {
  :databag            => 'ssh_key_wrapper',
  :cookbook           => 'ssh_key_wrapper',
  :template           => 'wrapper.erb',
  :enable_wrapper     => true,
  :user               => 'root',
  :group              => 'root',
  :private_keys   => {}
}
