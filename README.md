# Singularity image from Conda script

[![First env CI](https://github.com/horothesun/singularity-playground/actions/workflows/first-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-playground/actions/workflows/first-env-ci-linux.yml)
[![Second env CI](https://github.com/horothesun/singularity-playground/actions/workflows/second-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-playground/actions/workflows/second-env-ci-linux.yml)
[![Third env CI](https://github.com/horothesun/singularity-playground/actions/workflows/third-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-playground/actions/workflows/third-env-ci-linux.yml)
[![Singularity build](https://github.com/horothesun/singularity-playground/actions/workflows/singularity-build.yml/badge.svg)](https://github.com/horothesun/singularity-playground/actions/workflows/singularity-build.yml)

[Singularity](https://singularity.lbl.gov/) containerization of a Conda-based `bash` script.

## Requirements

- Conda ([install](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)) for [manual script execution](#manual-script-execution) and
- Docker for [local Singularity image build](#local-singularity-image-build).

## <a name="manual-script-execution"></a> Manual script execution

```bash
conda env update --file environment.yml
conda activate singularity-playground-env
./run.sh
```

## <a name="local-singularity-image-build"></a> Local Singularity image build

Run `quay.io/singularity` Docker image and access its `bash` with

```bash
docker run \
  --interactive --tty --rm --privileged \
  --volume $(pwd)/environment-01.yml:/go/environment-01.yml \
  --volume $(pwd)/environment-02.yml:/go/environment-02.yml \
  --volume $(pwd)/environment-03.yml:/go/environment-03.yml \
  --volume $(pwd)/run.sh:/go/run.sh \
  --volume $(pwd)/runscript.sh:/go/runscript.sh \
  --volume $(pwd)/Singularity.0.0.1:/go/Singularity.0.0.1 \
  --volume $(pwd)/out:/go/out \
  --entrypoint /bin/bash \
  quay.io/singularity/singularity:v3.7.2
```

then, from within the container's `bash` run

```bash
export IMAGE_FILENAME=/go/out/image.sif

# build
singularity build $IMAGE_FILENAME Singularity.0.0.1

# inspect
ls -lah $IMAGE_FILENAME
singularity inspect $IMAGE_FILENAME
singularity inspect --deffile $IMAGE_FILENAME

# run
singularity run $IMAGE_FILENAME
```
