#!/bin/bash

mkdir vm_ubuntu
cd vm_ubuntu

vagrant init ubuntu/trusty32;
vagrant up --provider virtualbox

vagrant ssh