#!/bin/bash
source `dirname $0`/../utils.sh

# constants
export RAILS_ENV=production

info "Packages installation"
execute sudo apt-get update
execute sudo apt-get install -y curl zip git sysstat r-base-core redis-server

info "Go to SCALARM_ROOT: $SCALARM_ROOT"
execute cd $SCALARM_ROOT

info "GSISSH installation - getting Globus repo"
execute wget http://toolkit.globus.org/ftppub/gt6/installers/repo/globus-toolkit-repo_latest_all.deb -O /tmp/globus-toolkit-repo_latest_all.deb

info "GSISSH installation - installing Globus repo"
execute sudo dpkg -i /tmp/globus-toolkit-repo_latest_all.deb && rm /tmp/globus-toolkit-repo_latest_all.deb

info "GSISSH installation - installing gsi-openssh-clients"
execute sudo apt-get update
execute sudo apt-get install -y gsi-openssh-clients libglobus-gssapi-gsi4

info "Installing PLGrid certificates (for gsissh)"
execute $SCRIPT_PATH/../install_plgrid_certs.sh

info "Installing Ruby from RVM"
execute $SCRIPT_PATH/../install_rvm.sh

info "Cloning scalarm_experiment_manager"
execute git clone https://github.com/Scalarm/scalarm_experiment_manager

info "Go to scalarm_experiment_manager application dir"
execute cd scalarm_experiment_manager

info "Checking out \"$GIT_BRANCH\" git branch"
execute git checkout $GIT_BRANCH

info "Installing gems"
execute bundle install
