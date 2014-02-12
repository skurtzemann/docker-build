#!/bin/bash
salt-call -l warning --master=wiki.kurtzemann.fr --id=docker state.highstate
/usr/bin/supervisord --nodaemon
