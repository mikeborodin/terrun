scripts/build.sh

cd build
tar -czf terrun.tar.gz terrun
sha=`shasum -a 256 terrun.tar.gz | cut -d " " -f 1`
echo $sha


cd ..
versionNotSplitted=`awk '/version:/ {print $2}' pubspec.yaml | sed "s/[,']//g"`
version=`awk -F+ '{print $1}' <<< "$versionNotSplitted"`

gh release create $version build/terrun.tar.gz --generate-notes

cp -r README.md ../homebrew-terrun/README.md

echo "
class Terrun < Formula
  desc \"terrun - efficient terminal runner\"
  homepage \"https://github.com/mikeborodin/terrun\"
  url \"https://github.com/mikeborodin/terrun/releases/download/$version/terrun.tar.gz\"
  sha256 \"$sha\"
  license \"MIT\"
  version \"$version\"

  def install
    bin.install \"terrun\"
  end
end" > ../homebrew-terrun/Formula/terrun.rb

cd ../homebrew-terrun
git add .
git commit -m "release $version"
git push origin main