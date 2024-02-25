var cloudFunctionUrl = 'https://us-central1-aerobic-amphora-409013.cloudfunctions.net/function-practice';

// Define the options for the fetch request
const options = {
  method: 'POST', // or 'GET', 'PUT', etc. depending on your cloud function's requirements
  headers: {
    'Content-Type': 'application/json' // Specify the content type
    // Add any additional headers if needed
  }
  
};

// Make the fetch request to the cloud function URL
fetch(cloudFunctionUrl, options)
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json(); // Parse the response JSON
  })
  .then(data => {
    // Handle the response data
    console.log('Response from cloud function:', data);
  })
  .catch(error => {
    // Handle any errors that occur during the fetch request
    console.error('Error calling cloud function:', error);
  });
