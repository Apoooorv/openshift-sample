FROM fedora:latest

RUN dnf -y install python-pip mod_wsgi python-gunicorn && \
    dnf -y clean all && \
    pip install django && \
    chmod a+rxw /home/ && \
    cd /home/ && \
    touch /home/gunicorn.logs && \
    django-admin startproject sample

EXPOSE 8080

ENTRYPOINT cd /home/sample/ && gunicorn --bind 0.0.0.0:8080 --access-logfile=/home/gunicorn.logs --pythonpath /home/sample/sample/ wsgi

