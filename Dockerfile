FROM ubuntu
RUN apt-get update && apt-get install -y python3 python3-pip
RUN apt-get install htop -y
RUN pip3 install jupyterlab
RUN pip3 install pivottablejs pandas pandasql seaborn matplotlib
RUN pip3 install pypyodbc
EXPOSE 8888