#!/usr/bin/env python3

import argparse
import re
import os
import shutil
from executedef import execute

parser = argparse.ArgumentParser()
parser.add_argument('--ZipFileName', help="Name of the zip file to be downloaded", required=True)
args = parser.parse_args()

zipfileName = args.ZipFileName

# zipfileName would be like Kiwi.BranchService.0.0.4.13.zip
print("#### Zipfile to be downloaded: " + zipfileName)
regex = r"Kiwi.(\w*)\.(\d+\.\d+\.\d+\.\d+)\.zip"

matchObj = re.match(regex, zipfileName)

if matchObj:
   # serviceName would be like 'BranchService'
   serviceName = matchObj.group(1)
   print("#### Service name: " + serviceName)
   # version would be like '0.0.4.13'
   versionName = matchObj.group(2)
   print("#### Version name: " + versionName)
else:
   print("#### Invalid zip file name, can't match service name")
   quit()

# Finding script file directory
sfp = os.path.realpath(__file__)
sfd = os.path.dirname(sfp)
print("#### Script file direcory: " + sfd)

cfn= sfd + "/compressfile/" + zipfileName  # Compress file path
# Service name to lower
snl = serviceName.lower()
pcd= sfd + "/publishcode/" + snl # Publish code directory

# Check zip[ already download and  exists
if os.path.isfile(cfn):
   print("#### File found!: " + cfn)
   print("#### Deleting it for fresh download")
   os.remove(cfn)

# Check if publish director already exists
if os.path.isdir(pcd):
   print("#### Publish code directory exist, deleting it for new download")
   shutil.rmtree(pcd)
else:
   # Create new directory
   print("#### Publish code directory does not exist, creating new one")
   os.makedirs(pcd)
   

# Download the zipfile from the google cloud
# GCP Service Name slag
gcpsn = serviceName.lower().replace(".","")
gscmd = "gsutil cp gs://kiwilivewinpackages/" + gcpsn + "/" + zipfileName + " " + cfn
print("#### Downloading new package from google cloud storage")
print(gscmd)
execute(gscmd)

#### Extracting the zip file downlaoded

# Folder to extract in the zip
ftoa = "Content/C_C/jenkins/publishkiwiservices/kiwi." + snl  + "/live/*"
print("#### Unzip in to the publishcode directory")
# unzip command
ucmd = "unzip " + cfn + " '" + ftoa + "' -d " + pcd
print(ucmd)
execute(ucmd, False)
# move content from inner directory to publishcode folder
print("#### Moving content to publishcode directory")
pdir = pcd + "/Content/C_C/jenkins/publishkiwiservices/kiwi." + snl  + "/live/*"
mvcmd = "mv " + pdir + " " + pcd
print(mvcmd)
execute(mvcmd)
# remove the content directory
print("#### Removing reduntant directory")
pdir = pcd + "/Content"
rmcmd = "rm -rf " + pdir
print(rmcmd)
execute(rmcmd)

