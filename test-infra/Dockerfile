FROM python:3

RUN apt-get update && apt-get -y install vim && apt-get clean

ADD entrypoint.sh /entrypoint.sh
ADD playbook /playbook
ADD hosts.template /etc/ansible/hosts

ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /playbook
ENTRYPOINT ["/entrypoint.sh"]
