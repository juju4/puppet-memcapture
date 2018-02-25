#init.pp
class memcapture (
  $dst_path = '/tmp/cases',
  $bin_path = "/tmp/ir-bin",
  Boolean $download = true,
  Boolean $build = true,
  Boolean $install = true,
  Boolean $capture = true,
  # if using fmem, this is required! or extract for /proc/meminfo? (dd count format)
  # 512MB = 536870912 = 0x1fffffff
  # 4GB = 4294967296 = 0x100000000
  $memory_size = '512',
  $memory_bs = '1M',
  $fmem_v = '1.6-1',
  Boolean $use_linpmem = true,
  Boolean $use_fmem = true,
  Boolean $use_lmg = true,
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
  ) {

  if $facts[osfamily] == 'windows' { 
    notice("Running memcapture on Windows")
    include ::memcapture::winpmem
  } elsif $facts[osfamily] == 'Darwin' { 
    notice("Running memcapture on Macos")
    include ::memcapture::osxpmem
  } else {
    notice("Running memcapture on Linux")
    include ::wget
    include ::memcapture::linpmem
  }
}
