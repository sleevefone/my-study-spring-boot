require 'formula'

class Springboot < Formula
  homepage 'https://spring.io/projects/spring-boot'
  url 'https://repo.spring.io/snapshot/org/springframework/boot/spring-boot-cli/2.0.10.BUILD-SNAPSHOT/spring-boot-cli-2.0.10.BUILD-SNAPSHOT-bin.tar.gz'
  version '2.0.10.BUILD-SNAPSHOT'
  sha256 '04066237c4f15ab0b6ed094ac12b74b58f98b5333390ba19362903a1bcdc763b'
  head 'https://github.com/spring-projects/spring-boot.git'

  if build.head?
    depends_on 'maven' => :build
  end

  def install
    if build.head?
      Dir.chdir('spring-boot-cli') { system 'mvn -U -DskipTests=true package' }
      root = 'spring-boot-cli/target/spring-boot-cli-*-bin/spring-*'
    else
      root = '.'
    end

    bin.install Dir["#{root}/bin/spring"]
    lib.install Dir["#{root}/lib/spring-boot-cli-*.jar"]
    bash_completion.install Dir["#{root}/shell-completion/bash/spring"]
    zsh_completion.install Dir["#{root}/shell-completion/zsh/_spring"]
  end
end
