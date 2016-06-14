FROM  jupyter/scipy-notebook

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
RUN pip2 install cclib
RUN pip2 install gpy
RUN pip2 install https://github.com/rpmuller/pyquante2/zipball/master
RUN pip2 install mongoengine
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
RUN pip3 install cclib
RUN pip3 install gpy
RUN pip3 install https://github.com/rpmuller/pyquante2/zipball/master
RUN pip3 install mongoengine
# update packages
RUN conda update -n python2 --all --quiet --yes
RUN conda update --all --quiet --yes

#jupyter theme selector
RUN mkdir /opt/conda/share/jupyter/nbextensions/jupyter_themes
RUN wget https://raw.githubusercontent.com/merqurio/jupyter_themes/master/theme_selector.js
RUN mv theme_selector.js /opt/conda/share/jupyter/nbextensions/jupyter_themes
RUN  jupyter nbextension enable jupyter_themes/theme_selector
#jupyter css
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY custom /home/jovyan/.jupyter/custom
# copy test files
COPY test /home/jovyan/

#RUN pip install psutil
#RUN git clone https://github.com/ipython-contrib/IPython-notebook-extensions
#RUN cd IPython-notebook-extensions && python setup.py install
#RUN cd IPython-notebook-extensions && python configure_nbextensions.py debug
#RUN rm -rf IPython-notebook-extensions

#COPY nbextensions /home/jovyan
#RUN pip install -U https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip --user
#RUN /opt/conda/lib/python3.5/site-packages/notebook/nbextensions.py
#RUN cat /home/jovyan/nbextensions >> /home/jovyan/.jupyter/jupyter_notebook_config.py
#RUN jupyter nbextension install /home/jovyan/.local/share/jupyter/nbextensions/usability/ruler/main
#RUN jupyter nbextension list

USER jovyan
