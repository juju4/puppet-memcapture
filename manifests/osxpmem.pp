# Memory capture
class memcapture::osxpmem {

  $osxpmem_bin = "${memcapture::bin_path}/osxpmem-2.1.post4"
  $osxpmem_capture = "${memcapture::dst_path}/${::hostname}-memory-osxpmem.${memcapture::osxpmem_ext}"

  file { $memcapture::bin_path:
    ensure => 'directory',
  }

  file { $memcapture::dst_path:
    ensure => 'directory',
  }

# FIXME!
# Debug: HTTP HEAD request to https://github-production-release-asset-2e65be.s3.amazonaws.com/19864741/061a2f04-210d-11e6-9598-b9f50db37ef5?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20180224%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180224T214020Z&X-Amz-Expires=300&X-Amz-Signature=aef728b302e6345567f94df481feedfe820a18ff0eccd19a10f287e96f636384&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dosxpmem-2.1.post4&response-content-type=application%2Foctet-stream returned 403 Forbidden
#  Error: /Stage[main]/Memcapture::osxpmem/File[osxpmem]: Could not evaluate: Could not retrieve information from environment production source(s) https://github.com/google/rekall/releases/download/v1.5.1/osxpmem-2.1.post4
#  file { 'osxpmem': 
#    path => $osxpmem_bin,
#    ensure => 'file',
#    mode => 'a+x',
#    source => $memcapture::osxpmem_url,
#  }

  wget::fetch { $memcapture::osxpmem_url:
    destination => $osxpmem_bin,
    timeout     => 15,
    verbose     => true,
    mode => 'a+x',
  }
  # wget does set correct mode
  file { 'osxpmem': 
    path => $osxpmem_bin,
    ensure => 'file',
    mode => 'a+x',
  }

  exec { 'capture memory':
    command => "$osxpmem_bin -o $osxpmem_capture",
    cwd => $memcapture::bin_path,
    umask => '077',
    user => 'root',
  }

  exec { 'generate hash of capture':
    command => "/usr/bin/shasum -a 512 $osxpmem_capture > $osxpmem_capture.sha512",
    cwd => $memcapture::bin_path,
    umask => '077',
  }

}
