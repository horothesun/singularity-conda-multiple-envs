# Singularity image from Conda multi-environment script

[![First env CI](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/first-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/first-env-ci-linux.yml)
[![Second env CI](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/second-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/second-env-ci-linux.yml)
[![Third env CI](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/third-env-ci-linux.yml/badge.svg)](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/third-env-ci-linux.yml)

[![Image build](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/image-build-linux.yml/badge.svg)](https://github.com/horothesun/singularity-conda-multiple-envs/actions/workflows/image-build-linux.yml)

[Singularity](https://singularity.lbl.gov/) containerization of a Conda-based multi-environment `bash` script.

## Requirements

- Conda ([install](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)) for [manual execution](#manual-execution) and
- Docker for [local Singularity image build](#local-singularity-image-build).

## <a name="manual-execution"></a> Manual execution

```bash
# environments creation
conda env update --file environment-01.yml
conda env update --file environment-02.yml
conda env update --file environment-03.yml

# run.sh in different environments
conda activate first-env
./run.sh

conda activate second-env
./run.sh

conda activate third-env
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
  --volume $(pwd)/singularity-image.def:/go/singularity-image.def \
  --volume $(pwd)/out:/go/out \
  --entrypoint /bin/bash \
  quay.io/singularity/singularity:v3.7.2
```

then, from within the container's `bash` run

```bash
export IMAGE_FILENAME=/go/out/image.sif

# build
singularity build $IMAGE_FILENAME singularity-image.def

# inspect
ls -lah $IMAGE_FILENAME
singularity inspect $IMAGE_FILENAME
singularity inspect --deffile $IMAGE_FILENAME

# run
singularity run $IMAGE_FILENAME
```

## Singularity image signing

Login into [Sylabs.io](https://cloud.sylabs.io/auth) and generate a Singularity Cloud token. Download the token file and save it to `~/.singularity/sylabs-token`.

To generate a new key to sign a Singularity image in a GitHub Action, run

```bash
singularity keys newpair
```

and publish the public key on the Singularity Cloud.

Then update the repository secrets as follows

- `SINGULARITY_CLOUD_TOKEN`: run `< ~/.singularity/sylabs-token | base64 | pbcopy` (on macOS) and paste the content of your clipboard as value of the secret,
- `SINGULARITY_PGP_PASSPHRASE`: newly generated key's `passphrase` and
- `SINGULARITY_PGP_SECRET_BASE64`: run `< ~/.singularity/sypgp/pgp-secret | base64 | pbcopy` (on macOS) and paste the content of your clipboard as value of the secret.
