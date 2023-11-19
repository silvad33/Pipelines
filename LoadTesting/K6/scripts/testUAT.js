import http from 'k6/http';
import { check } from 'k6';

export function setup() {
  const auth = http.post(__ENV.API_AUTH_URL, __ENV.API_AUTH_REQUEST_BODY, {
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
     },
  });
  return { authToken: auth.json().response.access_token };
}

export let options = {
  vus: 10,
  duration: '30s',
  ext: {
    loadimpact: {
      projectID: __ENV.PROJECT_ID,
      name: __ENV.TEST_NAME
    }
  },
  hosts: {
    'myorders-uat.presidio.com':	    '172.21.1.120',
    'myorders-api-uat.presidio.com':  '172.21.1.127',
    'phoenix-uat.presidio.com':	      '172.21.1.209',
    'mypresidio-uat.presidio.com':	  '172.21.1.108',
    'phoenix-api-uat.presidio.com':	  '172.21.1.104'
  },
}

export default function (data) {
  const result = http.get('https://phoenix-api-uat.presidio.com/v1.0/user/me', {
    headers: {
      'Authorization': `Bearer ${data.authToken}`
     },
  });
  console.log(result)
  check(result, {
    'http response status code is 200': result.status === 200,
  });
}