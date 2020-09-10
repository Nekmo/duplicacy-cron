#!/bin/sh

do_init() {
  : ${DUPLICACY_REPOSITORY:?'Missing DUPLICACY_REPOSITORY'}
  : ${DUPLICACY_SNAPSHOT_ID:?'Missing DUPLICACY_SNAPSHOT_ID'}
  : ${DUPLICACY_STORAGE_URL:?'Missing DUPLICACY_STORAGE_URL'}

  duplicacy init -repository "${DUPLICACY_REPOSITORY}" "${DUPLICACY_SNAPSHOT_ID}" "${DUPLICACY_STORAGE_URL}"
  if [[ $? != 0 ]]; then
    echo "duplicacy init command failed. Aborting" >&2
    rm -rf .duplicacy
    exit 1
  fi
}

if [[ ! -d .duplicacy/preferences ]]; then
    do_init
else
    echo 'This folder has already been initialized with duplicacy. Not initializing again'
fi

ofelia daemon --config=/etc/ofelia/config.ini
