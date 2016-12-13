# SharePoint Framework CI Docker Images

Docker images for running automated builds of [SharePoint Framework](https://github.com/SharePoint/sp-dev-docs) in continuous integration scenarios.

The docker image contains a precached node_modules (/var/spfx_precache/node_modules/) directory which you can 
symlink to your project directory with `ln -s /var/spfx_precache/node_modules/ node_modules`. This will speed up
your builds since the dependencies won't be downloaded again with every build. 

## Available tags
- **latest**: SharePoint Framework dependencies for the [developer preview drop 6](https://github.com/SharePoint/sp-dev-docs/wiki/Release-Notes-Drop-6)
- **drop-6**: SharePoint Framework dependencies for the [developer preview drop 6](https://github.com/SharePoint/sp-dev-docs/wiki/Release-Notes-Drop-6)

## Sample setup for Gitlab

The following CI configuration for GitLab utilizes the predownloaded spfx dependencies 
in the docker image by symlinking it in the project directory. Project specific dependencies
are cached in a local `.node_cache` directory which should be then passed between different
build by GitLab.

To configure the continuous integration in GitLab, just place the configuration settings in a file
called `.gitlab-ci-yml' in your project root.

```
image: artokai/spfx-ci

cache:
  key: "$CI_BUILD_REF_NAME"
  paths:
    - .node_cache/

stages:
  - build
  - test

before_script:
  - ln -s /var/spfx_precache/node_modules/ node_modules
  - mkdir -p .node_cache
  - npm prune
  - npm install --no-optional --cache .node_cache --cache-min Infinity

execute-build:
  stage: build
  script:
  - gulp build

execute-test:
  stage: test
  script:
  - gulp test


```