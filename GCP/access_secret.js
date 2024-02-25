const { SecretManagerServiceClient } = require('@google-cloud/secret-manager');

async function accessSecretVersion(projectId, secretId, versionId = 'latest') {
  // Create a Secret Manager client
  const client = new SecretManagerServiceClient();

  // Construct the full secret path
  const name = `projects/${projectId}/secrets/${secretId}/versions/${versionId}`;

  try {
    // Access the secret version
    const [version] = await client.accessSecretVersion({ name });

    // Extract the payload data
    const payload = version.payload.data.toString('utf8');

    console.log(`Secret value: ${payload}`);
    return payload;
  } catch (error) {
    console.error(`Error accessing secret: ${error.message}`);
    throw error;
  }
}

// Replace these values with your Google Cloud project ID and secret ID
const projectId = 'aerobic-amphora-409013';
const secretId = 'encryption_encoded_key';

// Call the function to access the secret
accessSecretVersion(projectId, secretId);
