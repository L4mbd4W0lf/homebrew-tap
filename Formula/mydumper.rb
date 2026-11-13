class Mydumper < Formula
  desc "MySQL database exporter and importer"
  homepage "https://github.com/mydumper/mydumper"
  url "https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.11-1.zip"
  version "1.0.11-1"
  sha256 "ab8b7a71caad0db33e5578481bc7e82992639a65722793dbbf50dde726b173a0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "mysql-client"
  depends_on "openssl@3"
  depends_on "pcre2"

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=Release
      -DMYSQL_CONFIG=#{Formula["mysql-client"].opt_bin}/mysql_config
      -DMYSQL_LIBRARIES=#{Formula["mysql-client"].opt_lib}/libmysqlclient.dylib
      -DMYSQL_INCLUDE_DIR=#{Formula["mysql-client"].opt_include}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"

    bin.install "build/mydumper", "build/myloader"

    etc.install "mydumper.cnf"
  end
end

