# Sample Content

This repository provides a small, curated collection of size-optimized images used as sample content in theme demos for the Automad CMS. The images are sourced from Unsplash and are made available under the [Unsplash License](https://unsplash.com/license).

The repository also includes a script to fetch images from a specified Unsplash collection, resize and convert them, and generate metadata and a contact sheet.

Processed images are stored in the images directory and committed to the repository. On push, the site is automatically built and deployed, exposing the assets via a CDN endpoint.

## Adding Images

In order to add images, follow these steps:

1. Create a `.env` file based on the `.env.example` file
2. Update the configured collection on [Unsplash](https://unsplash.com)
3. Run `bash fetch.sh`
4. Commit and push the added images
