# Test database example

This is an example project that illustrates how to use Liquibase with Docker to delivery instantly accessible development database and provide iamage that could be used
to deploy database changes in the controlled manner to the various environments.

The multi-stage Dockerfile in this project allows to create two Docker images:
1. The development/test database image with preloaded data set
2. The database deployment image

In both cases the same Liquibase changeset is used.

## Build stages

The docker file has three stages:
1. The 'deploy' stage which adds to the image all necessary files to run the `liquibase update` command
2. The 'build' stage which spins the database instance, applies the changeset including the test_data context and backs up the database
3. The final stage that again spins up the database and restores backup

**It is important that when all the stages are invoked during build, the `docker build` command is running when DOCKER_BUILDKIT is enabled!! Otherwise, the data are not restored (for whatever reason)**

## Building the images

In order to build a deployment image run the following command:

```
docker build -t test-db-deployment --target deploy .
```

To build the test database run the following command:
```
docker build -t test-db-deployment .
```