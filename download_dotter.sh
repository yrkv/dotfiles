#!/bin/sh

REPO="SuperCuber/dotter"
ASSET="dotter"


LATEST_TAG=$(curl --silent "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

wget "https://github.com/$REPO/releases/download/$LATEST_TAG/$ASSET"

chmod +x dotter
