#!/bin/sh

do_init() {
  : ${BACKUP_NAME:?'Missing BACKUP_NAME'}
  : ${BACKUP_LOCATION:?'Missing BACKUP_LOCATION'}

  duplicacy init -repository "${DUPLICACY_REPOSITORY}" "${DUPLICACY_SNAPSHOT_ID}" "${DUPLICACY_STORAGE_URL}"
  if [[ $? != 0 ]]; then
    echo "duplicacy init command failed. Aborting" >&2
    rm -rf .duplicacy
    exit 1
  fi
}

if [[ ! -d .duplicacy ]]; then
    do_init
else
    echo 'This folder has already been initialized with duplicacy. Not initializing again'
fi

ofelia daemon --config=/etc/ofelia/config.ini
