#!/bin/bash

for i in `seq 1 10`;
do
  HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://my-app-ELB-156639.us-east-1.elb.amazonaws.com:81/myweb-0.0.5/`
  if [ "$HTTP_CODE" == "200" ]; then
    echo "Successfully pulled root page."
    exit 0;
  fi
  echo "Attempt to curl endpoint returned HTTP Code $HTTP_CODE. Backing off and retrying."
  sleep 10
done
echo "Server did not come up after expected time. Failing."
exit 1
