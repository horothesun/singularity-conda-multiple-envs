#!/bin/bash

echo "Start runscript.sh..."
echo "---"

conda -V
echo "---"

conda info --envs
/run.sh
echo "---"

conda activate first-env
conda info --envs
/run.sh
echo "---"

conda activate second-env
conda info --envs
/run.sh
echo "---"

conda activate third-env
conda info --envs
/run.sh
echo "---"

echo "... end runscript.sh"
