#!/bin/bash

./execute.sh > output.txt

if cmp -s "./output.txt" "./expected.txt"; then
  echo "same"
else
  echo "not same"
fi
