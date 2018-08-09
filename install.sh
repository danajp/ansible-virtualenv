#!/bin/bash

set -eo pipefail

CT_VERSION=0.9.0
CT_URL=${CT_URL:-https://github.com/coreos/container-linux-config-transpiler/releases/download/v${CT_VERSION}/ct-v${CT_VERSION}-x86_64-unknown-linux-gnu}
VIRTUALENV_NAME=${VIRTUALENV_NAME:-ansible}

msg() {
  echo "$1" >&2
}

fatal() {
  msg "FATAL: $1"
  exit 1
}

assert_virtualenv() {
  if ! which virtualenv 2>/dev/null; then
    fatal "You need virtualenv to use this install (because it creates a virtualenv for you)"
  fi
}

assert_not_in_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    fatal "It looks like you have an active, virtualenv, this script won't work that way"
  fi
}

main() {
  assert_virtualenv
  assert_not_in_virtualenv

  local virtualenv_dir

  virtualenv_dir="$1"

  if [[ -z "$virtualenv_dir" ]]; then
    if [[ -z "$WORKON_HOME" ]]; then
      fatal "You must specify a virtualenv dir"
    fi

    msg "detected WORKON_HOME $WORKON_HOME, using virtualenv at $WORKON_HOME/$VIRTUALENV_NAME"
    virtualenv_dir="$WORKON_HOME/$VIRTUALENV_NAME"
  fi

  virtualenv "$virtualenv_dir"
  . "$virtualenv_dir/bin/activate"

  msg "Installing python requirements"
  pip install --upgrade -r requirements.txt

  msg "Installing ct"
  curl -sSL "$CT_URL" > "${VIRTUAL_ENV}/bin/ct"
  chmod +x "${VIRTUAL_ENV}/bin/ct"
}

main "$@"
