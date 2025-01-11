# Ad Query and Cookie Parameter Extractor

## Overview

The **Ad Query and Cookie Parameter Extractor** is a Google Tag Manager (GTM) custom template designed to extract specified ad query parameters from the URL and values from a specified cookie. The extracted data is returned for further processing within GTM.

## Features

- Extracts common ad query parameters such as `gclid`, `fbclid`, `utm_source`, and more.
- Retrieves values from a specified cookie, with `_shopify_sa_p` as the default cookie name.
- Returns extracted data for use in GTM.

## Setup Instructions

1. **Add the Template to GTM**:
   - Import the custom template into your GTM account.

2. **Configure the Template**:
   - **Cookie Name**: 
     - Default: `_shopify_sa_p`
     - Description: An optional field that contains `_shopify_sa_p` as the default value. Use this field if the cookie name differs.

3. **Use the Template**:
   - Add the template to a tag in GTM.
   - Configure the tag to use the extracted data as needed.

## Parameters

- **Ad Queries**: The template automatically extracts the following ad query parameters:
  - `gclid`
  - `fbclid`
  - `utm_source`
  - `utm_medium`
  - `utm_campaign`
  - `utm_content`
  - `utm_term`
  - `utm_id`
  - `msclkid`
  - `pr_rec_id`
  - `syclid`

- **Cookie Name**: 
  - Field Name: `cookiename`
  - Default Value: `_shopify_sa_p`
  - Help Text: An optional field that contains `_shopify_sa_p` as the default value. Use this field if the cookie name differs.

## Usage

- The template returns an object containing the extracted query parameters and cookie values.
- Use the returned data in GTM to trigger events, populate variables, or for other custom logic.

## Support

For any issues or questions, please contact the template developer or refer to the GTM documentation for custom templates.
