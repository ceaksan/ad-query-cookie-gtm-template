___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Ad Query and Cookie Parameter Extractor",
  "description": "This template extracts specified ad query parameters from the URL and values from a specified cookie. It returns the extracted data for further processing in Google Tag Manager.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "cookiename",
    "displayName": "Cookie Name",
    "simpleValueType": true,
    "defaultValue": "_shopify_sa_p",
    "help": "An optional field that contains _shopify_sa_p as the default value. Use this field if the cookie name differs."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const encodeUri = require('encodeUri');
const encodeUriComponent = require('encodeUriComponent');
const decodeUriComponent = require('decodeUriComponent');
const log = require('logToConsole');
const getQueryParameters = require('getQueryParameters');
const getCookieValues = require('getCookieValues');
const Object = require('Object'); // Require the Object API

log('data =', data);

const adQueries = [
  'gclid', 'fbclid', 'utm_source', 'utm_medium', 'utm_campaign',
  'utm_content', 'utm_term', 'utm_id', 'msclkid', 'pr_rec_id', 'syclid'
];

function getQueryParams() {
  const queryParams = {};
  adQueries.forEach(param => {
    const values = getQueryParameters(param, true);
    if (values && values.length > 0) {
      queryParams[param] = values; // Use array directly
    }
  });
  return queryParams;
}

function getCookieValue(name) {
  if (!name) {
    log('Cookie name is required');
    return null;
  }
  const values = getCookieValues(name);
  if (values && values.length > 0) {
    return values[0]; // Assuming you want the first value
  }
  log('Cookie with name ' + name + ' not found');
  return null;
}

function checkAdQueries() {
  let url = encodeUri(data.url);
  const urlParams = getQueryParams();
  const cookieName = data.cookiename; // Get the cookie name from the field
  const shopifyCookie = getCookieValue(cookieName);
  const foundParams = {};

  for (let i = 0; i < adQueries.length; i++) {
    const param = adQueries[i];
    if (urlParams[param]) {
      foundParams[param] = urlParams[param]; // Use array directly
    }
  }

  if (shopifyCookie) {
    for (let i = 0; i < adQueries.length; i++) {
      const param = adQueries[i];
      const encodedParam = encodeUriComponent(param) + '%3D';
      const startIndex = shopifyCookie.indexOf(encodedParam);
      if (startIndex !== -1) {
        const endIndex = shopifyCookie.indexOf('&', startIndex);
        const value = shopifyCookie.substring(startIndex + encodedParam.length, endIndex !== -1 ? endIndex : shopifyCookie.length);
        if (!foundParams[param]) {
          foundParams[param] = [];
        }
        foundParams[param].push(decodeUriComponent(value));
      }
    }
  }

  const queryParams = {};
  for (const key in foundParams) {
    if (foundParams.hasOwnProperty(key)) {
      queryParams[key] = foundParams[key];
    }
  }

  if (Object.keys(queryParams).length > 0) {
    return queryParams;
  }
  return null;
}

const result = checkAdQueries();
if (result) {
  return result; // Return the result instead of pushing to the data layer
}

// Call gtmOnSuccess to indicate the tag has completed successfully
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_shopify_sa_p"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 1/11/2025, 8:35:03 PM


