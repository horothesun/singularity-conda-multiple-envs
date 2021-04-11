#!/bin/bash

echo "Start create_conda_envs.sh..."

conda -V

conda env update --file /environment-01.yml
conda env update --file /environment-02.yml
conda env update --file /environment-03.yml

echo "... end create_conda_envs.sh"
