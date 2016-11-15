FROM  beangoben/pimp_jupyter

USER root
# make bash default shell
RUN apt-get update && \
    apt-get install -y gfortran && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jovyan
#python 2

# Chemioinformatics packages
RUN conda install -n python2 -c rdkit rdkit --quiet --yes
RUN conda install -n python2 -c omnia openbabel --quiet --yes
RUN pip2 install cclib
RUN pip2 install imolecule
RUN pip2 install https://github.com/rpmuller/pyquante2/zipball/master
#RUN pip2 install https://github.com/rpmuller/pyquante2/zipball/master
RUN wget http://downloads.sourceforge.net/project/pyquante/PyQuante-1.6/PyQuante-1.6.5/PyQuante-1.6.5.tar.gz && \
    tar xzvf PyQuante-1.6.5.tar.gz && \
    source activate python2 &&\
    cd PyQuante-1.6.5 && \
    python setup.py install && \
    cd .. && \
    rm -rf PyQuante-1.6.5*
# PY3DMOL
RUN pip2 install py3Dmol
#RUN pip2 install git+git://github.com/avirshup/py3dmol.git && \
#    wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/3Dmol-min.js && \
#    mv 3Dmol-min.js /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/3DMol-min.js && \
#    wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/callbacks.js && \
#    mv callbacks.js /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/ && \
#    wget https://raw.githubusercontent.com/avirshup/py3dmol/master/py3dmol/body.html && \
#    mv body.html /opt/conda/envs/python2/lib/python2.7/site-packages/py3dmol/

# copy test files
COPY test /home/jovyan/

USER jovyan



