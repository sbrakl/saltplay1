#!/bin/bash
zipfn='Kiwi.DemoAppService.0.0.1.0.zip'
cfn='./compressfile/'$zipfn # Compress file path


# Check if file exists
if [ -f $cfn ]; then
    echo "####  File found!: $cfn"
    echo "#### Deleting it for fresh download"
    rm -f $cfn
fi

# Check if publish code exist
if [ -d ./publishcode ]; then
    echo "#### Publish code directory exist, deleting"
    rm -rf ./publishcode
fi

# Download the zipfile
echo "#### Downloading new package from google cloud storage"
gsutil cp gs://kiwilivewinpackages/faltuservice/$zipfn $cfn

# Unzip the file to publish folder
echo "#### Unzip in to the publishcode directory"
unzip $cfn -d .
