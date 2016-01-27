class archivesspace_dev::bootstrap {

    ##  Need to assemble the config file and attach it to the
    #   mysql database at this point.
    #

    #file { '/opt/archivesspace/common/config/config.rb' :
    #  ensure => present,
    #  source => 'puppet://modules/archivesspace/dev-config.rb',
    #  mode   => '0644',
    #  notify => Exec['build/run'],
    #}

    exec { 'build/run' :
      command  => '/opt/archivesspace/build/run bootstrap',
      cwd      => '/opt/archivesspace',
      require  => Vcsrepo['/opt/archivesspace'],
      notify   => File [ '/opt/archivesspace/.aspace-installed/' ],
      timeout  => 1800,
      creates  => '/opt/archivesspace/gems/gems',
    }

    $msg = "This file is a marker to stop puppet Exec from
    re-installing aspace-dev. Puppet will not re-run
    build/run bootstrap if this file exists."

    file { '/opt/archivesspace/.aspace-installed':
      ensure  => present,
      content => $msg,
    }

}