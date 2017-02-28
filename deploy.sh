# Move to the release branch
git checkout release

git merge develop

let release_number=`cat release | sed -e s/r//g`+1
release="r$release_number"
echo $release > ./release
git add ./release

echo "Performing release $release"
git commit -m "Performing release $release"
git tag -a $release -m "Release $release"
git push -f origin release
git push origin $release

# Revert to the previous git branch
git checkout -

# Deploy updated release branch to server. Checkout release as detached head.
ssh sirius "cd /var/www/46b.it/_46bit && git fetch --tags && git checkout tags/$release"
