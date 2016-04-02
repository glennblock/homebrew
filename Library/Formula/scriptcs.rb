class Scriptcs < Formula
  desc "Tools to write and execute C#"
  homepage "https://github.com/scriptcs/scriptcs"
  url "https://github.com/scriptcs/scriptcs/archive/v0.16.0.tar.gz"
  sha256 "e51060406606010f1ea67ae2573fcd7bc75b40ebe990ba546c7b646f6b4bdaba"

  bottle do
    cellar :any
    sha256 "dfead67e3f9fbdb499b480eb2b29d651010b1815ef5fe0425affd4ce07295739" => :yosemite
    sha256 "eec5baf497fc37444fc37adf7c7c761011bb50059f21ccaf10620f0887e759f6" => :mavericks
    sha256 "206b8fd283ab15e49c91941c2dad77950adb5a9642bb8563a530f4a79d2ccaf3" => :mountain_lion
  end

  depends_on "mono" => :recommended

  def install
    script_file = "scriptcs.sh"
    system "./build.sh"
    libexec.install Dir["src/ScriptCs/bin/Release/*"]
    (libexec/script_file).write <<-EOS.undent
      #!/bin/bash
      mono #{libexec}/scriptcs.exe $@
    EOS
    (libexec/script_file).chmod 0755
    bin.install_symlink libexec/script_file => "scriptcs"
  end

  test do
    test_file = "tests.csx"
    (testpath/test_file).write('Console.WriteLine("{0}, {1}!", "Hello", "world");')
    assert_equal "Hello, world!", `scriptcs #{test_file}`.strip
  end
end
