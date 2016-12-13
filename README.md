# SharePoint Framework CI Docker Images

Docker images for running automated builds of [SharePoint Framework](https://github.com/SharePoint/sp-dev-docs) in continuous integration scenarios.

The docker image contains a precached node_modules (/var/spfx_precache/node_modules/) directory which you can 
symlink to your project directory with `ln -s /var/spfx_precache/node_modules/ node_modules`. This will speed up
your builds since the dependencies won't be downloaded again with every build. 

## Available tags
- **latest**: SharePoint Framework dependencies for the [developer preview drop 6](https://github.com/SharePoint/sp-dev-docs/wiki/Release-Notes-Drop-6)
- **drop-6**: SharePoint Framework dependencies for the [developer preview drop 6](https://github.com/SharePoint/sp-dev-docs/wiki/Release-Notes-Drop-6)

## Sample setup for Gitlab

```
image: artokai/spfx-ci

before_script:
  - ln -s /var/spfx_precache/node_modules/ node_modules
  - npm prune
  - npm install --no-optional

build:
  script:
  - gulp build

test:
  script:
  - gulp test

```