#!/bin/bash

function reset_ufw_rule(){
  echo "RESET UFW RULE"
  sudo ufw reset
}
reset_ufw_rule
