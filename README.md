# SonarQube Quality Gate Check Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to check the SonarQube Quality Gate status for a specified branch.

This plugin requires a SonarQube API token and project key.

Other preinstalled requirements:

- [`curl`](https://curl.haxx.se/)
- [`jq`](https://stedolan.github.io/jq/)

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: "echo 'Running SonarQube Quality Gate Check''"
    plugins:
      - robert-fahey/sonarqube-quality-gate-checker-buildkite-plugin#v1.0:
          api_token: "your-sonarqube-api-token"
          project_key: "your-sonarqube-project-key"
```

## Configuration

### `api_token` (required, string)

Your SonarQube API token to authenticate against the SonarQube Quality Gate endpoint.

### `project_key` (required, string)

The key that identifies your SonarQube project.

## Developing

To run the tests:

```shell
docker-compose run --rm shellcheck
docker-compose run --rm tests
```

## Contributing

1.  Fork the repo
2.  Make the changes
3.  Run the tests
4.  Commit and push your changes
5.  Send a pull request
