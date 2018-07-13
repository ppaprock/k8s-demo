#!/bin/bash

ACT=$(whiptail --menu "Choose action" 20 80 8 \
RUN "Run local" \
STOP "Stop local" \
PUSH "Build & push to docker hub" \
K8CREATE "Create kubernetes google cloud" \
K8DELETE "Delete kubernetes google cloud" 3>&2 2>&1 1>&3)

[ -z "$ACT"  ] && exit 0

cd scripts

case $ACT in
  "RUN") ./buildAndRunLocal.sh ;;
  "STOP") ./stopLocal.sh ;;
  "PUSH") ./buildAndPushImages.sh ;;
  "K8CREATE") ./k8sCreateAll.sh ;;
  "K8DELETE") ./k8sDeleteAll.sh ;;
esac
