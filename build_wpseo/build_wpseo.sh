#!/bin/bash
set -x
set -e

. /Users/hugo/productivity_scripts/build_wpseo/build_wpseo.config;

current_path=$(pwd);

# Get cmnd line arguments (see https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script)
# defaults
premium='';
dorequire='';
quick='false';
verbose='false';

print_usage() {
  printf "Usage: ..."
}

while getopts 'pr:q' flag; do
  case "${flag}" in
    p) premium='true' ;;
    r) echo "${OPTARG}"
       dorequire="${OPTARG}" ;;
    q) quick='true' ;;
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
  grunt build:js
  cd $current_path
  pwd
  exit 32
fi


composer install
yarn
grunt build

cd $current_path
pwd

