#/etc/puppet/manifests/site.pp

stage{[1,2,3,4,5,6]:}
stage[1] -> stage[2] -> stage[3] -> stage[4] -> stage[5] -> stage[6]

node "puppet.linux.org" {
	include instalacion
	include permisos
	include hola_mundo
	include configurarResolv
}

class{ 'instalacion'		: stage => 1 }
class{ 'configurarResolv'	: stage => 2 }
class{ 'hola_mundo'		: stage => 3 }
class{ 'permisos'		: stage => 4 }

class instalacion{
	exec{"yum -y install bind bind-utils":
		creates => '/var/named',
		command => '/usr/bin/yum -y install bind bind-utils',
	}
}


class configurarResolv{
	file{"/etc/resolv.conf":
		content => "search linux.org
domain linux.org
nameserver 127.0.0.1
"
	}
}

class permisos{
	exec{"chown named:named /var/named/dominiogcc2.com.zone":
		command => '/bin/chown named:named /var/named/dominiogcc2.com.zone',
	}
	exec{"chown named:named /var/named/dgcc2ptr.com.zone":
		command => '/bin/chown named:named /var/named/dgcc2ptr.com.zone',
	}
	exec{"service named start":
		command => '/sbin/service named start',
	}
	exec{"chkconfig named on":
		command => '/sbin/chkconfig named on',
	}
	exec{"firewall-cmd --permanent --zone-public --add-service=http":
		command => '/bin/firewall-cmd --permanent --zone=public --add-service=http',
	}
	exec{"firewall-cmd --reload":
		command => '/bin/firewall-cmd --reload',
	}
}
