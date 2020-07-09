class Envoy < Formula
  desc "Cloud-native high-performance edge/middle/service proxy"
  homepage "https://www.envoyproxy.io"
  url "https://github.com/envoyproxy/envoy.git",
      :tag     => "v1.15.0",
      :version => "50ef0945fa2c5da4bff7627c3abf41fdd3b7cffd"

  depends_on "aspell" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bazelisk" => :build
  depends_on "clang-format" => :build
  depends_on "cmake" => :build
  depends_on "coreutils" => :build
  depends_on "go" => :build
  depends_on "libtool" => :build
  depends_on "ninja" => :build
  depends_on "wget" => :build

  def install
    args = %w[
      --curses=no
      --show_task_finish
      --verbose_failures
      --action_env=PATH=/usr/local/bin:/opt/local/bin:/usr/bin:/bin
      --test_output=all
    ]
    system "bazelisk", "build", *args, "//source/exe:envoy-static"

    pp Dir["**/*"]
  end

  test do
    system bin/"envoy", "--help"
  end
end
