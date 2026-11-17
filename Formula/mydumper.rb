class Mydumper < Formula
  desc "MySQL database exporter and importer"
  homepage "https://github.com/mydumper/mydumper"
  url "https://github.com/mydumper/mydumper/archive/refs/tags/v1.0.19-1.tar.gz"
  sha256 "03c2db71c62af5db4b12ee0c50b43b841c45efab36c8f1073f6d0d0c92d9bcad"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "mysql-client"
  depends_on "openssl@3"
  depends_on "pcre2"

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=Release
      -DMYSQL_CONFIG=#{formula_opt_bin("mysql-client")}/mysql_config
      -DMYSQL_LIBRARIES=#{formula_opt_lib("mysql-client")}/libmysqlclient.dylib
      -DMYSQL_INCLUDE_DIR=#{formula_opt_include("mysql-client")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"

    bin.install "build/mydumper", "build/myloader"

    etc.install "mydumper.cnf"
  end

  test do
    assert_match version.to_s.split("-").first, shell_output("#{bin}/mydumper --version")
    assert_match version.to_s.split("-").first, shell_output("#{bin}/myloader --version")
  end
end
