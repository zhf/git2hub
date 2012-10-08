error_not_in_repo()
{
	echo "Not in a git repo with remote url."
	exit 101
}

error_not_github()
{
	echo "Repo not hosted on Github."
	exit 102
}

URL=`git config --get-all remote.origin.url`
test -z "$URL" && error_not_in_repo

echo $URL | grep -q github || error_not_github

REPO=`echo $URL | cut -f 2 | cut -d ':' -f 2 | cut -d '/' -f 2 | cut -d '.' -f 1`
USER=`echo $URL | cut -f 2 | cut -d ':' -f 2 | cut -d '/' -f 1`

unset RELATIVE_PATH

while ! test -d '.git'
do
	RELATIVE_PATH="`basename $(pwd)`/$RELATIVE_PATH"
	cd ..
done

test "`uname`" = "Darwin" && open "https://github.com/$USER/$REPO/tree/master/$RELATIVE_PATH$*"
