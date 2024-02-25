######## Dockerfile,metadata.json,requirements.txt,my_pipeline.py must be inside a single directory together
######## Run all below CLI commands inside that directry ##########
####### to change directory "cd directory_name"
-------------------------------------------------------------------------------------
#to speed up buids

gcloud config set builds/use_kaniko True

-------------------------------------------------------------------------------------
###########create container image 👇


export TEMP_IMAGE="gcr.io/poc-task-379506/samples/dataflow/aggpipe:latest"
gcloud builds submit --tag "$TEMP_IMAGE" .

# Build the image into Container Registry, this is roughly equivalent to:
#   gcloud auth configure-docker
#   docker image build -t $TEMPLATE_IMAGE .
#   docker push $TEMPLATE_IMAGE
#   Here "poc-task-379506" is the project id

--------------------------------------------------------------------------------------

##############create flex template 👇

export TEMPLATE_PATH="gs://bt_poc/Templates/flexlatest.json"
gcloud dataflow flex-template build $TEMPLATE_PATH \
    --image "$TEMP_IMAGE" \
    --sdk-language "PYTHON" \
    --metadata-file "credes.json"

>>>>>>>>>>To run a flex dataflow job template>>>>>>>>>>>>>>>>>

gcloud dataflow flex-template run "flextest" \
    --template-file-gcs-location "gs://bt_poc/Templates/flex1.json" \
    --parameters input_path="gs://bt_poc/Templates/input_file.json" \
    --parameters output_path="poc-task-379506:ds_km.flex_test" \
    --parameters temp_location="gs://bt_poc/Templates/temp" \
    --region "us-east" \ --parameters staging_location="gs://bt_poc/Templates/temp23"