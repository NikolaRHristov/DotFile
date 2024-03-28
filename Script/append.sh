#!/bin/bash

cat package.json | jq '. + {
	"private": false,
	"publishConfig": {
		"access": "public"
	},
	"author": {
		"email": "nikola@playform.cloud",
		"name": "Nikola R. Hristov",
		"url": "https://nikolahristov.tech"
	},
	"license": "MIT",
	"type": "module",
}' >|package.json

sort-package-json
