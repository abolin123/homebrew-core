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
    system "bazelisk", "build", "--action_env=PATH=#{Formula["llvm@10"].opt_bin}:#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin", "//source/exe:envoy-static"
  end
end
