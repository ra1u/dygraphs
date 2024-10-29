#!/bin/bash
# This generates everything under dist:
# bundled JS, minified JS, minified CSS and source maps.
set -e

# to run in docker 
# podman run -it --rm -w $PWD -v $PWD:$PWD node bash 

# to install UNCOMMENT the following lines
npm install --include=dev
export PATH=$PATH:./node_modules/.bin

# bunde everything togeter in namespace Dygraphs
rollup src/dygraph.js \
	   -o dist/dygraph.rollup.js \
	   --sourcemapFile dist/dygraph.js.map \
	   --format iife \
	   --name Dygraphs 



babel dist/dygraph.rollup.js  --out-file dist/dygraph.js --presets babel-preset-es2015

#minify
uglifyjs \
		 -o dist/dygraph.min.js \
		 dist/dygraph.js

# uglify css
cp css/dygraph.css dist/
cleancss css/dygraph.css -o dist/dygraph.min.css \
		 --source-map --source-map-inline-sources 


