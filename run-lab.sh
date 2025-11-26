#!/bin/bash
# Set all variables to start de script
PROJECT=$(gcloud config get-value project)
BUCKET_NAME="$PROJECT-bucket"
REGION="europe-west1"
ZONE="us-east1-c"
IMAGE_NAME="ada.jpg"
FOLDER_NAME="image-folder"

echo "gcloud auth list and proy"
gcloud auth list
gcloud config list project
gcloud config set compute/region $REGION

# Create a BUCKET by command line
echo "Create a BUCKET by command line"
gcloud storage buckets create gs://$BUCKET_NAME

# move image to test the service in Bucket via cloud
echo "download and upload images to bucket"
curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output $IMAGE_NAME
gcloud storage cp $IMAGE_NAME gs://$BUCKET_NAME
rm $IMAGE_NAME

# Download again the image from bucket to local
gcloud storage cp -r gs://$BUCKET_NAME/$IMAGE_NAME .
echo "image dounloaded"
ls

# create a folder
gcloud storage cp gs://$BUCKET_NAME/$IMAGE_NAME gs://$BUCKET_NAME/$FOLDER_NAME/

# List all the files on the bucket
gcloud storage ls gs://$BUCKET_NAME

# list detalles oll the files on the bicket
gcloud storage ls -l gs://$BUCKET_NAME/$IMAGE_NAME

# access to all users to the bucket
gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME/$IMAGE_NAME
echo "updated permissions"

#validate the public access
curl "review if the image is public"

# delete ACL permissions
gutils acl ch -d AllUsers gs://$BUCKET_NAME/$IMAGE_NAME
echo "removed permisions"


# remove the image
gcloud storage rm gs://$BUCKET_NAME/$IMAGE_NAME
echo "removed image"




