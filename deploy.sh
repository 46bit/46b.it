# read "rN" from ./release
# merge latest develop commit into release
# tag latest commit with "rN+1"
# write "rN+1" to ./release
# push release branch to github
# ssh vega 'cd /var/www/46b.it/webroot && git pull origin release'

let release_number=`cat release | sed -e s/r//g`+1
release="r$release_number"
echo "Performing release $release"

git checkout release
git merge develop
git tag -a $release
echo $release > ./release

git push origin release
ssh vega 'cd /var/www/46b.it/webroot && git pull origin release'
