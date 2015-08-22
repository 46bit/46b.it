git checkout release

# Contain ./release file within release branch. Read only once checked out.
let release_number=`cat release | sed -e s/r//g`+1
release="r$release_number"
echo "Performing release $release"

# Merge changes from develop
git merge develop

# Write, commit, tag and push new release name.
echo $release > ./release
git add ./release
git commit -m "Performing release $release"
git tag -a $release -m "Release $release"
git push origin release
git push origin $release

# Check develop back out. It would be nicer to require fast-forward merges so
# this process could be done without checking out.
git checkout develop

# Deploy updated release branch to server. Checkout release as detached head.
ssh sirius "cd /var/www/46b.it/_46bit && git fetch && git checkout $release"
