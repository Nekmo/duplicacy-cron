Duplicacy cron
##############
Docker image based on `duplicacy-autobackup <https://github.com/christophetd/duplicacy-autobackup/>`_ but with several
improvements:

* ``duplicacy-cron`` uses `standard duplicacy environment variables <https://forum.duplicacy.com/t/passwords-credentials-and-environment-variables/1094/1>`_.
* Crons use `Ofelia <https://github.com/mcuadros/ofelia>`_, a modern cron service built for docker.
* Multiple cron can be configured for multiple backups.
* Backup volumes (``/host``) and duplicacy configuration (``/duplicacy``) are different. Host volume can be mounted
  read-only.
* Duplicacy commands can be executed easily. For example ``docker-compose duplicacy exec duplicacy check``.
* Duplicacy commands can be executed easily. For example ``docker-compose duplicacy exec duplicacy check``.


docker-compose example
======================

.. code-block:: yaml

    version: '3.6'
    services:

      duplicacy:
        build:
          context: .
          dockerfile: Dockerfile
        volumes:
          - /:/host
          - ./conf/duplicacy:/duplicacy/.duplicacy
          - ./conf/ofelia:/etc/ofelia
        environment:
          DUPLICACY_SNAPSHOT_ID: mymachine
          DUPLICACY_STORAGE_URL: s3://amazon/mymachine
          DUPLICACY_REPOSITORY: /host
          DUPLICACY_PASSWORD: '***************'
          DUPLICACY_S3_ID: '***************'
          DUPLICACY_S3_SECRET: '***************'
