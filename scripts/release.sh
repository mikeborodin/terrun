cd build
tar -czf terrun.tar.gz terrun
sha=`shasum -a 256 terrun.tar.gz`
echo $sha

