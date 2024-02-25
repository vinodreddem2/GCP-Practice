import io
import base64
import json

from tink import KeysetHandle 
from tink import JsonKeysetWriter, JsonKeysetReader
from tink import aead, cleartext_keyset_handle

from google.cloud import secretmanager
from google.cloud import bigquery

def access_secret_version():
    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    project_id = "aerobic-amphora-409013"
    secret_id = "encryption_key"
    version_id = "latest"
    # Build the resource name of the secret version.
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"

    # Access the secret version.
    response = client.access_secret_version(name=name)

    # Return the decoded payload.
    encrypt_key = response.payload.data.decode('UTF-8')
    return encrypt_key

def encrypt_data(plaintext):
    
    keyset = access_secret_version() 

    aead.register()

    reader = JsonKeysetReader(keyset)
    
    keyset_handle1 = cleartext_keyset_handle.read(reader)

    aead_primitive = keyset_handle1.primitive(aead.Aead)
    tink_ciphertext = aead_primitive.encrypt(plaintext, b'practice')
    print(f"tink_ciphertext : {tink_ciphertext} ")


    # plain_text = aead_primitive.decrypt(tink_ciphertext,b'practice')
    # print(f"plain_text : {plain_text} ")


    return base64.b64encode(tink_ciphertext).decode()



# data_to_encrypt = "abcedef".encode('utf-8')
# encrypt_data(data_to_encrypt)




def write_to_bq():
    client = bigquery.Client(project="aerobic-amphora-409013")
    dataset_ref = client.dataset("gcp_practice")
    table_ref = dataset_ref.table("test_tbl")

    row = {"name":"sai","phone_number":"1234567890","city":"Bangalore"}

    row['phone_number'] = encrypt_data(row['phone_number'].encode('utf-8'))
  
    print(f" row : {row}")

    bq_rows = []
    bq_rows.append(row)
    if bq_rows:
        client.insert_rows_json(table=table_ref, json_rows=bq_rows)

write_to_bq()