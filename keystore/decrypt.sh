#!/bin/sh

gpg --quiet --batch --yes --decrypt --passphrase="$KEYPASSWORD" --output upload-keystore.jks upload-keystore.jks.gpg
