#/etc/puppet/modules/hola_mundo/manifests/init.pp

class hola_mundo{
	file{"/etc/sysconfig/network-scripts/ifcfg-enp0s3":
		content => template("/etc/puppet/modules/hola_mundo/templates/sys.erb"),
	}
	file{"/etc/dhcp/dhcpd.conf":
		content => template("/etc/puppet/modules/hola_mundo/templates/confdhcp.erb"),
	}
	file{"/etc/named.rfc1912.zones":
		content => template("/etc/puppet/modules/hola_mundo/templates/rfcdom.erb"),
	}
	file{"/var/named/dominiogcc2.com.zone":
		ensure => present,
		content => template("/etc/puppet/modules/hola_mundo/templates/gcc1.erb"),
	}
	file{"/var/named/dgcc2ptr.com.zone":
		ensure => present,
		content => template("/etc/puppet/modules/hola_mundo/templates/gcc2.erb"),
	}
}
