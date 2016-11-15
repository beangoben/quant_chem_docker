# Docker repo for Quantum Chemistry
## What's included?

Docker files to test-out basic cheminformatics and quantum chemistry.

The docker image is based off of <https://github.com/beangoben/pimp_jupyter>, a scientific jupyter notebook image with enabled nbextensions. Also included:

- Pyquante 1.6.5 and pyquante2
- RDKIT
- Openbabel
- 3dmoljs and imolecule for visualization
- cclib


## How to use/build

To run the software on any computer you need to install [docker](https://www.docker.com/).

Then you can either download or build the docker image.

To download running the following command in your favorite terminal:

```
docker pull beangoben/quant_chem_docker
```

of build it (good to change things) by moving to the git cloned repository :

```
docker build -t "beangoben/quant_chem_docker" .
```

And then move to whatever folder you want to work with and execute:

```
docker run -p 8888:8888 -v $(pwd):/home/jovyan/work -it beangoben/quant_chem_docker
```
