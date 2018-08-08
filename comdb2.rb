class Comdb2 < Formula
  desc "Clustered RDBMS built on Optimistic Concurrency Control techniques."
  homepage "https://bloomberg.github.io/comdb2"
  url "https://github.com/bloomberg/comdb2/archive/master.zip"
  version "7.0"
  #sha256 "4e3908133e6c785dd4ca95c6477359b5cbd8d8d28fc41d7f71e1b792710d4e55"
  depends_on "cmake" => :build
  depends_on "lz4"
  depends_on "openssl"
  depends_on "protobuf-c"
  depends_on "readline"

  def datadir
    var/"cdb2"
  end

  def logdir
    var/"log/cdb2"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCOMDB2_ROOT=#{HOMEBREW_PREFIX}"
      system "make", "install"
    end
  end

  def post_install
    datadir.mkpath
    logdir.mkpath
  end

  test do
    begin
      dbname = "testdb"
      dir = Dir.pwd
      system bin/"comdb2", "--create", "--dir", dir, dbname
      
      pmux = fork do
        exec bin/"pmux", "-f"
      end
      sleep 10

      comdb2 = fork do
        exec bin/"comdb2", dbname, "--dir", dir
      end
      sleep 10

      output = shell_output("#{bin/"cdb2sql"} #{dbname} --host 127.0.0.1 'SELECT comdb2_version();'")
      assert_match "(comdb2_version()='R7.0pre ()')", output
    ensure
      Process.kill(9, comdb2)
      Process.wait(comdb2)
      Process.kill(9, pmux)
      Process.wait(pmux)
    end
  end
end
