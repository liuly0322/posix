///|
fn main {
  let (dir, rc_dir) = @native.CStr::from_bytes(b"tmp\x00")
  let (file, rc_file) = @native.CStr::from_bytes(b"input.txt\x00")
  let dirfd = @posix.openat(
    @posix.at_fdcwd, dir, @posix.o_directory, @posix.directory_default_mode,
  )
  let fd = @posix.openat(dirfd, file, @posix.o_wronly, @posix.file_default_mode)
  let status = @posix.ftruncate(fd, 5)
  if status.is_success() {
    println("ftruncate successfully")
  } else {
    println("failed to ftruncate")
  }
  rc_dir.release()
  rc_file.release()
  @posix.close(fd) |> ignore
  @posix.close(dirfd) |> ignore
}
