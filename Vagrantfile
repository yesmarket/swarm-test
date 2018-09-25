require 'json'
require 'getoptlong'

nodes = JSON.parse(File.read('nodes.json'), object_class: OpenStruct)

Vagrant.configure(2) do |config|

   nodes.each do |node|

      config.vm.define node[:name] do |guest|

         guest.vm.box = node[:box]
         guest.vm.hostname = node[:name]
         guest.vm.synced_folder '.', '/vagrant', type: 'rsync'

            config.vm.provider 'hyperv' do |hv|

               guest.vm.network 'public_network', bridge: 'Vagrant Switch'
               guest.vm.provision :shell, :path => 'provision/networking.sh', :args => "'#{node[:ip]}' '#{node[:netmask]}' 'eth0'", privileged: true
               guest.vm.provision :shell, :path => 'provision/proxy.sh', :args => "'#{ENV['HTTP_PROXY']}'", privileged: true
               guest.vm.provision :shell, :path => 'provision/node.sh', privileged: true

               hv.vmname = node[:name]
               hv.memory = node[:memory]
               hv.cpus = node[:cpus]

            end

      end

   end

end
