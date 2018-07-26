require 'json'
require 'getoptlong'

nodes = JSON.parse(File.read('nodes.json'), object_class: OpenStruct)

Vagrant.configure(2) do |config|

   nodes.each do |node|

      config.vm.define node[:name] do |guest|

         guest.vm.box = node[:box]
         guest.vm.hostname = node[:name]
         guest.vm.synced_folder '.', '/vagrant', type: 'rsync'

         guest.vm.provider 'virtualbox' do |vb|

            guest.vm.network 'private_network', ip: node[:ip], :netmask => node[:netmask], auto_config: true
            guest.vm.provision :shell, :path => 'provision/proxy.sh', :args => "'#{ENV['HTTP_PROXY']}'", privileged: true
            guest.vm.provision :shell, :path => 'provision/node.sh', privileged: true

            vb.name = node[:name]
            vb.memory = node[:memory]
            vb.cpus = node[:cpus]

         end

      end

   end

end
