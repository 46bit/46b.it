set -eu

let release_number=`cat release | sed -e s/r//g`+1
release="r$release_number"
echo $release > ./release
git add ./release

echo "Performing release $release"
git commit -m "Releasing $release"
git push
git tag -a $release -m "Release $release"
git push origin $release

ssh -q sirius \
  "cd /var/www/46b.it/_46bit && \
   git fetch --tags && \
   git checkout tags/$release"
