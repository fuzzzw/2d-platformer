#!/bin/bash
rm -fr build/ 2>/dev/null
mkdir build/
cd src
zip -9 -r ../build/love2d.love .
