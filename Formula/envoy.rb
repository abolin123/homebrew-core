class Envoy < Formula
  desc "Cloud-native high-performance edge/middle/service proxy"
  homepage "https://www.envoyproxy.io"
  url "https://github.com/envoyproxy/envoy.git",
      :tag     => "v1.15.0",
      :revision => "50ef0945fa2c5da4bff7627c3abf41fdd3b7cffd"

  depends_on "llvm@10" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bazelisk" => :build
  depends_on "cmake" => :build
  depends_on "coreutils" => :build
  depends_on "libtool" => :build
  depends_on "ninja" => :build

  def install
    llvm = Formula["llvm@10"]
    
    ENV.prepend_create_path "LDFLAGS", "-L#{llvm.opt_lib} -Wl,-rpath,#{llvm.opt_lib}"
    ENV.prepend_create_path "CPPFLAGS", "-I#{llvm.opt_include}"
    
    action_env = "PATH=#{llvm.opt_bin}:#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin"

    target = "source/exe:envoy-static.stripped"
    system "bazelisk", "build", "--action_env=#{action_env}", "//#{target}"
    bin.install "bazel-bin/#{target}" => "envoy"
  end
end
