#! /bin/bash
# Use FFMPEG to Convert Multiple Media Files At Once
# https://linuxconfig.org/how-to-use-ffmpeg-to-convert-multiple-media-files-at-once-on-linux

srcExt=$1
destExt=$2
srcDir=$3
destDir=$4
opts=$5

for filename in "$srcDir"/*.$srcExt; do
  basePath=${filename%.*}
  baseName=${basePath##*/}

  ffmpeg -i "$filename" $opts "$destDir"/"$baseName"."$destExt"
done

echo "Conversion from ${srcExt} to ${destExt} complete!"

# Example: Convert .avi to the .mp4 container (copy)
# ffmpeg-batch.sh avi mp4 ./path ./dest '-c:v copy -c:a copy -y'
