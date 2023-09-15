#!/bin/bash

# Configurations: Edit these to your needs
VM_NAME="your-vm-name"  # Default is empty, provide VM name as a command-line argument
STATIC_IP_NAME="new-static-ip"  # Default static IP name, change if necessary
REGION="asia-east1"  # Default region, modify as needed

# Functions for color-coded outputs
blue() {
    echo -e "\033[34m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}
red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

# Check for VM_NAME
if [[ "$VM_NAME" == "" ]]; then
    red "Please provide the VM name as a command-line argument."
    exit 1
fi

# Check if user is logged in to gcloud
if [[ $(gcloud auth list --format="value(account)") == "" ]]; then
    red "Please log in to your Google Cloud account first."
    exit 1
fi

green "Creating a new static IP..."
gcloud compute addresses create $STATIC_IP_NAME --region=$REGION

green "Fetching the new static IP..."
NEW_IP=$(gcloud compute addresses describe $STATIC_IP_NAME --region=$REGION --format="value(address)")

yellow "Deleting existing access configurations..."
gcloud compute instances delete-access-config $VM_NAME --access-config-name "external-nat"

green "Assigning new IP to VM..."
gcloud compute instances add-access-config $VM_NAME --address $NEW_IP

blue "New IP address is: $NEW_IP"

yellow "Deleting static IP to avoid extra charges..."
gcloud compute addresses delete $STATIC_IP_NAME --region=$REGION --quiet

green "IP change and DDNS update completed."
