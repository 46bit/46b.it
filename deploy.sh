let release_number=`cat release | sed -e s/r//g`+1
release="r$release_number"
echo $release > ./release
git add ./release

git commit -m "Performing release $release"
git push
git tag -a $release -m "Release $release"
git push origin $release

ssh sirius "cd /var/www/46b.it/_46bit && git fetch --tags && git checkout tags/$release"
