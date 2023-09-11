#!/bin/sh

. ~/etc/colours

TOP="$(git rev-parse --show-toplevel)"

function help(){
  echo "${green}This is the testing tool${NC}"
  echo "$0 ${purple}[full/create/destroy/ssh]${NC}"
  echo "${green}You can also SSH to a single host using $0 ssh${NC}"
  exit 1
}

function tasks(){
  cowthink -p -W 60 "COMMENT [$1]"
  echo "${2}ok: [localhost]${NC}"
}

function create(){
  tasks "Building instance ..." "${BLUE}"
  ansible-playbook ${TOP}/testing/playbooks/create.yml &&
  ansible-playbook -i ${TOP}/testing/inventory ${TOP}/testing/playbooks/prepare.yml ||
  tasks "That errored" "${red}"
  tasks "Create and prep done, now running the test playbook" "${green}"
}

function destroy(){
  tasks "just check for an instance and clean it up" "${BLUE}"
  ansible-playbook ${TOP}/testing/playbooks/destroy.yml ||
  tasks "That errored" "${red}"
  tasks "All clean" "${green}"
}
case "$1" in
  "full")
    destroy
    tasks "Start of testing" "${BLUE}"
    tasks "Linting Yaml files..." "${BLUE}"
    ansible-lint . ||
    tasks "You need to fix that lint" "${red}"
    create
    ansible-playbook -i ${TOP}/testing/inventory ./molecule/default/converge.yml ||
    tasks "That errored" "${red}"
    ansible-playbook -i ${TOP}/testing/inventory ./molecule/default/verify.yml ||
    tasks "That errored" "${red}"
    destroy
    tasks "testing complete" "${green}"
    ;;
  "create")
    create
    ;;
  "destroy")
    destroy
    ;;
  "lint")
    tasks "Linting Yaml files..." "${BLUE}"
    ansible-lint . ||
      tasks "You need to fix that lint" "${red}"
    ;;
  "-h")
    help
    ;;
  *)
    tasks "Start of testing" "${BLUE}"
    ansible-playbook -i ${TOP}/testing/inventory ./molecule/default/converge.yml ||
    tasks "That errored" "${red}"
    ansible-playbook -i ${TOP}/testing/inventory ./molecule/default/verify.yml ||
    tasks "That errored" "${red}"
    tasks "testing complete" "${green}"
    ;;
esac
