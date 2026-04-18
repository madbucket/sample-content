# Sample Content

This repository provides a small, curated collection of size-optimized images used as sample content in theme demos for the Automad CMS. The images are sourced from Unsplash and are made available under the [Unsplash License](https://unsplash.com/license).

The repository also includes a script to fetch images from a specified Unsplash collection, resize and convert them, and generate metadata and a contact sheet.

Processed images are stored in the images directory and committed to the repository. On push, the site is automatically built and deployed, exposing the assets via a CDN endpoint.

## Setup

Fetching and building is handled entirely by GitHub workflows. In order to set fetchin up, create a `UNSPLASH_ACCESS_KEY` repository secret and a `UNSPLASH_COLLECTION_ID` variable in the repository settings.

For local development, the same settings can be configured using an `.env` file.

## Adding Images

In order to add images, follow these steps:

1. Update the configured collection on [Unsplash](https://unsplash.com)
2. Trigger the `Fetch Images` workflow on GitHub
