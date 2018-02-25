[![Build Status - Master](https://travis-ci.org/juju4/puppet-memcapture.svg?branch=master)](https://travis-ci.org/juju4/puppet-memcapture)
[![Build Status - Devel](https://travis-ci.org/juju4/puppet-memcapture.svg?branch=devel)](https://travis-ci.org/juju4/puppet-memcapture/branches)
[![Appveyor - Master](https://ci.appveyor.com/api/projects/status/6vknet8n61t0u0fb/branch/master?svg=true)](https://ci.appveyor.com/project/juju4/puppet-memcapture)
![Appveyor - Devel](https://ci.appveyor.com/api/projects/status/6vknet8n61t0u0fb/branch/devel?svg=true)

# puppet-memcapture

## Module Description
This module download pmem tools from github rekall repositoris and do a memory capture of the host.
You are advised to use network shares to store files.

### Variable List

``` puppet
$dst_path = '/tmp/cases',
$bin_path = '/tmp/ir-bin',
$download = true,
$capture = true,
$use_linpmem = true,
$winpmem_v = '2.1.post4',
$winpmem_url = 'https://github.com/google/rekall/releases/download/v1.5.1/winpmem-2.1.post4.exe',
$winpmem_ext = 'img',
#$winpmem_v = '1.6.2',
#$winpmem_url = 'https://github.com/google/rekall/releases/download/v1.3.1/winpmem_1.6.2.exe',
#$winpmem_ext = 'img',
$linpmem_v = '2.1.post4',
$linpmem_url = 'https://github.com/google/rekall/releases/download/v1.5.1/linpmem-2.1.post4',
$linpmem_ext = 'img',
$osxpmem_v = '2.1.post4',
$osxpmem_url = 'https://github.com/google/rekall/releases/download/v1.5.1/osxpmem-2.1.post4',
$osxpmem_ext = 'raw',
#$osxpmem_ext = 'map',    # = aff4
```

### Operating systems

This module is targeted for Linux, Macos and Windows as supported by pmem tools.

## Continuous integration

you can test this role with test kitchen or travis.
```
$ cd /path/to/puppet-memcapture
$ KITCHEN_YAML=".kitchen.docker.yml" kitchen verify
$ KITCHEN_YAML=".kitchen.docker.yml"kitchen login
```
Memory capture will not work inside containers.

## Troubleshooting & Known issues

N/A

## License

BSD 2-clause