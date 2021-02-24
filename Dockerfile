FROM mltooling/ml-workspace-r

USER root

RUN conda install -y seaborn scikit-learn statsmodels numba pytables
RUN conda install -y python-igraph leidenalg
RUN pip3 install -y scanpy
RUN conda install -y tensorflow=1.13.1
RUN conda install -y keras
RUN conda install -y IPython
RUN pip3 install -e git+https://github.com/marcoancona/DeepExplain.git#egg=deepexplain

# use global option with tini to kill full process groups: https://github.com/krallin/tini#process-group-killing
ENTRYPOINT ["/tini", "-g", "--"]

CMD ["python", "/resources/docker-entrypoint.py"]

# Port 8080 is the main access port (also includes SSH)
# Port 5091 is the VNC port
# Port 3389 is the RDP port
# Port 8090 is the Jupyter Notebook Server
# See supervisor.conf for more ports

EXPOSE 8080
###
