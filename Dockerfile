FROM  beangoben/pimp_jupyter

USER root
# make bash default shell
RUN ln -snf /bin/bash /bin/sh
RUN apt-get update && \
    apt-get install -y mongodb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER jovyan
#python 2

# Chemioinformatics packages
RUN conda install -n python2 -c rdkit rdkit=2016.03.1 --quiet --yes
RUN conda install -n python2 -c omnia openbabel=2015.09 --quiet --yes
RUN conda install -n python2 anaconda-nb-extensions -c anaconda-nb-extensions --quiet --yes
RUN pip2 install cclib
RUN pip2 install https://github.com/rpmuller/pyquante2/zipball/master
RUN pip2 install git+git://github.com/scikit-learn/scikit-learn.git
# PY3DMOL
RUN pip2 install git+git://github.com/avirshup/py3dmol.git
RUN wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/3Dmol-min.js
RUN mv 3Dmol-min.js /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/3DMol-min.js
RUN wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/callbacks.js
RUN mv callbacks.js /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/
RUN wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/body.html
RUN mv body.html /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/
#Python 3
RUN conda install -c rdkit rdkit=2016.03.1 --quiet --yes
RUN conda install -c omnia openbabel=2015.09 --quiet --yes
RUN conda install anaconda-nb-extensions -c anaconda-nb-extensions --quiet --yes
RUN pip3 install cclib
RUN pip3 install https://github.com/rpmuller/pyquante2/zipball/master
RUN pip3 install git+git://github.com/scikit-learn/scikit-learn.git

# update packages
RUN conda update -n python2 --all --quiet --yes
RUN conda update --all --quiet --yes

# copy test files
COPY test /home/jovyan/

USER jovyan



