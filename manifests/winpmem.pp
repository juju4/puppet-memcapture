# Memory capture
class memcapture::winpmem {

  $winpmem_bin = "${memcapture::bin_path}/winpmem-2.1.post4.exe"
  $winpmem_capture = "${memcapture::dst_mount}/${::hostname}-memory-winpmem.${memcapture::winpmem_ext}"

  file { 'winpmem':
    ensure => 'file',
    path   => $winpmem_bin,
    mode   => 'a+x',
    source => $memcapture::winpmem_url,
  }

  exec { 'capture memory':
    command => "${winpmem_bin} -o ${winpmem_capture}",
    cwd     => $memcapture::bin_path,
  }

  exec { 'generate hash of capture':
    command  => "Get-FileHash -Algorithm SHA512 -Path ${winpmem_capture} > ${winpmem_capture}.sha512",
    provider => 'powershell',
    cwd      => $memcapture::bin_path,
  }

}
