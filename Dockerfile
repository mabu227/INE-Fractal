FROM ubuntu:latest

RUN apt-get -qq -y update && \
    apt-get -y install git tree nano python3 python3-pygments && \
    apt-get -qq -y upgrade && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Create user "student"
RUN useradd -m student && \
    cp /root/.bashrc /home/student/ && \
    echo 'gb() { git branch --show-current 2>/dev/null; }' >> /home/student/.bashrc && \
    echo 'export PS1="\e[0;35m\W\e[0m|\e[0;32m\$(gb)\e[0m $ "' >> /home/student/.bashrc && \
    echo 'alias pcat="pygmentize -f terminal256 -O style=native -g"' >> /home/student/.bashrc && \
    echo 'git config --global user.email "student@example.com"' >> /home/student/.bashrc && \
    echo 'git config --global user.name "Git Learner"' >> /home/student/.bashrc && \
    echo 'git config --add --global core.pager less' >> /home/student/.bashrc && \
    mkdir /home/student/versions && \
    chown -R --from=root student /home/student
ENV HOME /home/student
WORKDIR ${HOME}
USER student

ADD versions /home/student/versions
