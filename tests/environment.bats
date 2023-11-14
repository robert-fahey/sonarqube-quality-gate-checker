#!/usr/bin/env bats

setup() {
  load "$BATS_PLUGIN_PATH/load.bash"
}

quality_gate_check_script="$PWD/hooks/environment"

@test "SonarQube Quality Gate status is OK" {
  export PROJECT_KEY="RobertFahey_example-api" 
  export BUILDKITE_BRANCH="2.25.0"
  export API_TOKEN="45963A6D4A4046A08D4DDEA07B15FBAB" # This is just for testing. Don't expose your real token!

  stub curl \
     "-g -s -u 45963A6D4A4046A08D4DDEA07B15FBAB: 'https://sonarcloud.io/api/qualitygates/project_status?projectKey=RobertFahey_example-api&branch=2.25.0' : echo '{\"projectStatus\":{\"status\":\"OK\"}}'"

  run "${quality_gate_check_script}"

  assert_success
  assert_output --partial "SonarQube Quality Gate status is OK."

  unstub curl

  unset PROJECT_KEY
  unset BUILDKITE_BRANCH
  unset API_TOKEN
}

@test "SonarQube Quality Gate status is NOT OK" {
  export PROJECT_KEY="RobertFahey_example-api"    
  export BUILDKITE_BRANCH="2.25.0"
  export API_TOKEN="45963A6D4A4046A08D4DDEA07B15FBAB" # This is just for testing. Don't expose your real token!

  stub curl \
      "-g -s -u 45963A6D4A4046A08D4DDEA07B15FBAB: 'https://sonarcloud.io/api/qualitygates/project_status?projectKey=RobertFahey_example-api&branch=2.25.0' : echo '{\"projectStatus\":{\"status\":\"ERROR\"}}'"

  run "${quality_gate_check_script}"

  assert_failure
  assert_output --partial "SonarQube Quality Gate status is NOT OK!"

  unstub curl

  unset PROJECT_KEY
  unset BUILDKITE_BRANCH
  unset API_TOKEN
}
