#!/usr/bin/env bats

setup() {
  export SCRIPT="$BATS_TEST_DIRNAME/../node-reinstall"
}

@test "script has valid bash syntax" {
  run bash -n "$SCRIPT"

  [ "$status" -eq 0 ]
}

@test "--help prints usage and exits before privileged operations" {
  run "$SCRIPT" --help

  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
  [[ "$output" == *"--nvm-latest"* ]]
  [[ "$output" != *"sudo"* ]]
}

@test "-v prints the package version" {
  run "$SCRIPT" -v

  [ "$status" -eq 0 ]
  [ "$output" = "0.0.17" ]
}

@test "unknown options fail with usage output" {
  run "$SCRIPT" --not-a-real-option

  [ "$status" -eq 1 ]
  [[ "$output" == *"Unknown option"* ]]
  [[ "$output" == *"Usage:"* ]]
}
