# ansible

## install
pip install ansible

## setup
```
ansible-galaxy collection install community.general
ansible-playbook --ask-become-pass local.yml
```

# todo's
- rvm and ruby
- split up install packages
- clone dotfiles and run stow
- run rustup
- go
- typescript
- SSH keys and passwords
- arc
- doppler
- github cli

## ubuntu container

apt update
apt install python3-pip


Dockerfile

FROM ubuntu:latest
RUN apt update
RUN apt install --assume-yes sudo
RUN apt install --assume-yes python3-pip
RUN useradd -ms /bin/bash jcaffey
RUN echo "jcaffey:jcaffey" | chpasswd
RUN usermod -aG sudo jcaffey
USER jcaffey
WORKDIR /home/jcaffey
ADD dotfiles /home/jcaffey
# docker is running as root (i think) so $HOME wont work here
ENV PATH="$PATH:/home/jcaffey/.local/bin"
RUN pip install ansible
# path isnt working...
RUN ansible-galaxy collection install community.general
# don't do this... docker can cache this for us so i moved it to RUN commands
# RUN echo 'jcaffey' | sudo -S bash install.sh
CMD /bin/bash

docker build -t ubuntutest:latest .
docker run -it ubuntutest:latest
