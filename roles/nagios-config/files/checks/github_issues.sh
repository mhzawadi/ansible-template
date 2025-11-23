#/bin/sh

if [ $# -lt 2 ]
then
  echo "Missing options"
  echo "$0 <SERVICESTATEID> <SERVICENOTESURL>"
  exit 1
else
  STATUSID=$1
  ISSUEID=$2
fi

case ${STATUSID} in
  0)
    ISSUELABEL='operational'
    ;;
  1)
    ISSUELABEL='partial outage'
    ;;
  2)
    ISSUELABEL='major outage'
    ;;
  3)
    ISSUELABEL='major outage'
    ;;
esac

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer GITHUB-TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  ${ISSUEID}/labels \
  -d "{\"labels\":[\"component\",\"issue status\",\"$ISSUELABEL\"]}"
