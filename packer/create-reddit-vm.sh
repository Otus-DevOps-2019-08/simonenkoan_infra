#!/bin/bash
############
# Bash script to install Ruby&Mongodb packages
# Written by sserdj7@gmail.com for OTUS
############
gcloud compute instances create reddit-vm \
--image-family reddit-full \
--image-project nostromo-253518
