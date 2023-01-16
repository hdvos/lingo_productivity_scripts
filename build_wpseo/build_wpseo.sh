#!/bin/bash
set -x
set -e

. /Users/hugo/Projects/productivity_scripts/build_wpseo/build_wpseo.config;

current_path=$(pwd);

# Get cmnd line arguments (see https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
# defaults
premium='';
dorequire='';
quick='false';
verbose='false';
force='false'
watch='false'

print_usage() {
  printf "Usage: ..."
}

while getopts 'pr:qfw' flag; do
  case "${flag}" in
    p) premium='true' ;;
    r) echo "${OPTARG}"
       dorequire="${OPTARG}" ;;
    q) quick='true' ;;
    f) force='true' ;;
    w) watch='true' ;;
    *) print_usage 
       exit 1 ;;
  esac
done

echo "premium: $premiun";

package_root="$wpseo_location"
if [[ $premium ]]
then
  package_root="$wpseo_premium_location"
fi

echo "package root $package_root"

cd $package_root
echo "Changed to..."
pwd

echo "${dorequire}"

if [ $premium == "true" ] && [ -n $dorequire ]
then
  composer require yoast/wordpress-seo:dev-${dorequire}@dev
else
  echo "Nothing to require"
fi

if [[ $quick == "true" ]]
then
  if [ $force == 'true' ]
  then
    grunt build:js --force
  else
    grunt build:js
  fi

  cd $current_path
  pwd
  exit 0
fi


composer install
yarn

if [ $force == 'true' ]
then
  grunt build --force
else
  grunt build

if [ $watch == 'true' ] && [ $premium == 'true' ]
then
  grunt webpack:watch
elif [ $watch == 'true' ] && [ $premium == 'false' ]
then
  grunt shell:webpack-watch
fi



cd $current_path
pwd

